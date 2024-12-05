module Api
  module V1
    class ClockInSummariesController < ApiController
      include Pagination

      def index
        page = params[:page] || 1
        limit = params[:limit] || 32
        start_date = Time.zone.parse(params[:start_date]) if params[:start_date].present?
        start_date = 1.week.ago if start_date.blank?

        end_date = Time.zone.parse(params[:end_date]) if params[:end_date].present?
        end_date =  Time.zone.today if end_date.blank?

        query = ClockInSummary.where(user_id: params[:user_id])
                .where(schedule_date: start_date..end_date).order(schedule_date: :desc)

        pagination, records = Pagination.new(request.path).paginate(query, page: page, limit: limit)
        options = { links: pagination.links.as_json, meta: { pagination: pagination.details } }

        render json: ClockInSummarySerializer.new(records, options).serializable_hash, status: :ok
      end

      def followings
        page = params[:page] || 1
        limit = params[:limit] || 32
        start_date = Time.zone.parse(params[:start_date]) if params[:start_date].present?
        start_date = (Time.zone.today.beginning_of_week - 1.week) if start_date.blank?

        end_date = Time.zone.parse(params[:end_date]) if params[:end_date].present?
        end_date =  Time.zone.today if end_date.blank?

        query = ClockInSummary.followings_of(params[:user_id])
              .where(schedule_date: start_date..end_date)
              .order(sleep_duration_minute: :desc)

        pagination, records = Pagination.new(request.path).paginate(query, page: page, limit: limit)
        options = { links: pagination.links.as_json, meta: { pagination: pagination.details } }

        render json: ClockInSummarySerializer.new(records, options).serializable_hash, status: :ok
      end
    end
  end
end
