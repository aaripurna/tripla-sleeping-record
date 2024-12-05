class ClockInCreateForm
  include ActiveModel::Model
  attr_accessor :user_id, :event_type

  validate :clock_in_record_validation

  def initialize(params = {})
    super
    @errors = ActiveModel::Errors.new(OpenStruct.new)
  end

  def save
    false if invalid?

    ActiveRecord::Base.transaction do
      summary = if @clock_in.sleep_start?
        ClockInSummary.create!(user_id: user_id, schedule_date: @clock_in.schedule_date, status: :incomplete)
      else
        ClockInSummary.find_by!(user_id: user_id, schedule_date: @clock_in.schedule_date, status: :incomplete)
      end

      if @clock_in.sleep_start?
        summary.sleep_start = @clock_in.event_time
      else
        summary.sleep_end = @clock_in.event_time
        summary.status = :completed
        summary.sleep_duration_minute = (summary.sleep_end - summary.sleep_start) / 60 # convert second to minute
      end

      summary.save!
      @clock_in.save!
    end
  end

  private

  def clock_in_record_validation
    initialize_clock_in_record
    unless @clock_in.valid?
      errors.merge!(@clock_in.errors)
    end
  end

  def initialize_clock_in_record
    @clock_in = ClockIn.new(
      user_id: user_id,
      event_type: event_type,
      event_time: Time.zone.now
    )

    if @clock_in.sleep_start?
      @clock_in.schedule_date = Time.zone.today
      return
    end

    latest_sleep_start = ClockIn.order(id: :desc).where(user_id: user_id).first

    if latest_sleep_start.blank? || latest_sleep_start.sleep_end?
      @errors.add(:event_type, "must be done after sleep start")
    else
      @clock_in.schedule_date = latest_sleep_start.schedule_date
    end
  end
end
