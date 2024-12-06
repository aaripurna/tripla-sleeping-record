# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

ActiveRecord::Base.transaction do
  user =  FactoryBot.create(:user, name: "Lucy")
  user_2 =  FactoryBot.create(:user, name: "Gus")
  user_3 =  FactoryBot.create(:user, name: "Greg")

  date = (Time.zone.today - 1.week)


  FactoryBot.create(:follow, follower_id: user.id, followee_id: user_2.id)
  FactoryBot.create(:follow, follower_id: user.id, followee_id: user_3.id)

  # Followings

  FactoryBot.create(:clock_in_summary,
      user_id: user_2.id, sleep_start: date.change(hour: 22), sleep_end: (date + 1.day).change(hour: 6),
      status: :completed, sleep_duration_minute: 480, schedule_date: date)

  FactoryBot.create(:clock_in_summary,
    user_id: user_2.id, sleep_start: (date + 1.day).change(hour: 22), sleep_end: (date + 2.day).change(hour: 6),
    status: :completed, sleep_duration_minute: 480, schedule_date: (date + 1.day))

  FactoryBot.create(:clock_in_summary,
    user_id: user_2.id, sleep_start: (date + 2.day).change(hour: 22), sleep_end: (date + 3.day).change(hour: 6),
    status: :completed, sleep_duration_minute: 480, schedule_date: (date + 2.day))

  FactoryBot.create(:clock_in_summary,
    user_id: user_3.id, sleep_start: date.change(hour: 22), sleep_end: (date + 1.day).change(hour: 6),
    status: :completed, sleep_duration_minute: 480, schedule_date: date)

  FactoryBot.create(:clock_in_summary,
    user_id: user_3.id, sleep_start: (date + 1.day).change(hour: 22), sleep_end: (date + 2.day).change(hour: 6),
    status: :completed, sleep_duration_minute: 480, schedule_date: (date + 1.day))

  FactoryBot.create(:clock_in_summary,
    user_id: user_3.id, sleep_start: (date + 2.day).change(hour: 22), sleep_end: (date + 3.day).change(hour: 6),
    status: :completed, sleep_duration_minute: 480, schedule_date: (date + 2.day))

  # User's Data
  FactoryBot.create(:clock_in, user_id: user.id, event_type: :sleep_start, event_time: date.change(hour: 22), schedule_date: date)
  FactoryBot.create(:clock_in, user_id: user.id, event_type: :sleep_end, event_time: (date + 1.day).change(hour: 6), schedule_date: date)
  FactoryBot.create(:clock_in_summary,
      user_id: user.id, sleep_start: date.change(hour: 22), sleep_end: (date + 1.day).change(hour: 6),
      status: :completed, sleep_duration_minute: 480, schedule_date: date)

  FactoryBot.create(:clock_in, user_id: user.id, event_type: :sleep_start, event_time: (date + 1.day).change(hour: 22), schedule_date: (date + 1.day))
  FactoryBot.create(:clock_in, user_id: user.id, event_type: :sleep_end, event_time: (date + 2.day).change(hour: 6), schedule_date: (date + 1.day))
  FactoryBot.create(:clock_in_summary,
    user_id: user.id, sleep_start: (date + 1.day).change(hour: 22), sleep_end: (date + 2.day).change(hour: 6),
    status: :completed, sleep_duration_minute: 480, schedule_date: (date + 1.day))

  FactoryBot.create(:clock_in, user_id: user.id, event_type: :sleep_start, event_time: (date + 2.day).change(hour: 22), schedule_date: (date + 2.day))
  FactoryBot.create(:clock_in, user_id: user.id, event_type: :sleep_end, event_time: (date + 3.day).change(hour: 6), schedule_date: (date + 2.day))
  FactoryBot.create(:clock_in_summary,
    user_id: user.id, sleep_start: (date + 2.day).change(hour: 22), sleep_end: (date + 3.day).change(hour: 6),
    status: :completed, sleep_duration_minute: 480, schedule_date: (date + 2.day))
end
