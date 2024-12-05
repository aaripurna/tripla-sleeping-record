
require "rails_helper"

RSpec.describe ClockInCreateForm do
  let(:user) { create(:user) }
  let(:event_type) { :sleep_start }
  let(:params) { { user_id: user.id, event_type: event_type } }

  subject(:form) { described_class.new(params) }

  describe "#save" do
    context "data invalid" do
      context "sleep_end before sleep start" do
        let(:event_type) { :sleep_end }
        it "raises error ActiveRecord::RecordNotFound" do
          expect(form).to_not be_valid
          expect(form.errors.added?(:event_type, "must be done after sleep start"))
        end
      end

      context "multiple sleep_start a day" do
        before do
          create(:clock_in, user_id: user.id, schedule_date: Time.zone.today, event_type: :sleep_start, event_time: Time.zone.now)
        end

        it 'returns error' do
          expect(form).to_not be_valid
          expect(form.errors.added?(:user_id, :taken, value: user.id)).to be true
        end
      end

      context "multiple sleep_end in a row" do
        before do
          create(:clock_in, user_id: user.id, schedule_date: Time.zone.today, event_type: :sleep_end, event_time: Time.zone.now)
        end

        let(:event_type) { :sleep_end }

        it 'returns error' do
          form = described_class.new(params)
          expect(form).to_not be_valid
          expect(form.errors.added?(:event_type, "must be done after sleep start")).to be true
        end
      end
    end

    context "data valid" do
      let(:local_time) { Time.zone.parse("2024-01-01 22:00") }

      context "creating sleep start" do
        it "returns true" do
          travel_to(local_time) do
            expect(form.save).to be true
          end
        end
        it "saves ClockIn record" do
          travel_to(local_time) do
            expect { form.save }.to change(ClockIn, :count).by(1)
            clock_in = ClockIn.where(user_id: user.id).last
            expect(clock_in.event_time).to eq(local_time)
            expect(clock_in.schedule_date).to eq(local_time.to_date)
          end
        end

        it "saves ClockInSummary record" do
          travel_to(local_time) do
            expect { form.save }.to change(ClockInSummary, :count).by(1)
            summary = ClockInSummary.order(id: :desc).where(user_id: user.id, schedule_date: Time.zone.today).first

            expect(summary.status).to eq('incomplete')
            expect(summary.sleep_start).to eq(local_time)
            expect(summary.sleep_end).to be_nil
            expect(summary.sleep_duration_minute).to be_nil
          end
        end

        context "previous records is incomplete and then create a new sleep start" do
          let!(:clock_in_previous) { create(:clock_in, user_id: user.id, event_type: :sleep_start, event_time: local_time - 1.day, schedule_date: (local_time - 1.day).to_date) }
          let!(:summary_previous) { create(:clock_in_summary, user_id: user.id, status: :incomplete, schedule_date: (local_time - 1.day).to_date, sleep_start: local_time - 1.day) }

          it "creates record in current date" do
            travel_to local_time do
              expect { form.save }.to change(ClockIn, :count).by(1)
              .and change(ClockInSummary, :count).by(1)

              clock_in = ClockIn.where(user_id: user.id).last
              expect(clock_in.event_time).to eq(local_time)
              expect(clock_in.schedule_date).to eq(local_time.to_date)

              summary = ClockInSummary.order(id: :desc).where(user_id: user.id, schedule_date: Time.zone.today).first

              expect(summary.status).to eq('incomplete')
              expect(summary.sleep_start).to eq(local_time)
              expect(summary.sleep_end).to be_nil
              expect(summary.sleep_duration_minute).to be_nil
            end
          end
        end
      end

      context "creating sleep end" do
        let!(:clock_in_previous) { create(:clock_in, user_id: user.id, event_type: :sleep_start, event_time: local_time, schedule_date: local_time.to_date) }
        let!(:summary_previous) { create(:clock_in_summary, user_id: user.id, status: :incomplete, schedule_date: local_time.to_date, sleep_start: local_time) }
        let(:event_type) { :sleep_end }

        it "creates the records" do
          travel_to(local_time + 8.hours) do
            expect { form.save }.to change(ClockIn, :count).by(1)
              .and change(ClockInSummary, :count).by(0)

              clock_in = ClockIn.where(user_id: user.id).last
              expect(clock_in.event_type).to eq("sleep_end")
              expect(clock_in.event_time).to eq(local_time + 8.hours)
              expect(clock_in.schedule_date).to eq(local_time.to_date)


              summary = ClockInSummary.order(id: :desc).where(user_id: user.id).first

              expect(summary.status).to eq("completed")
              expect(summary.schedule_date).to eq(local_time.to_date)
              expect(summary.sleep_start).to eq(local_time)
              expect(summary.sleep_end).to eq(local_time + 8.hours)
              expect(summary.sleep_duration_minute).to eq(480)
          end
        end

        context "create sleep end a week later" do
          it "saved to the latest summary" do
            travel_to(local_time + 8.hours + 7.days) do
              expect { form.save }.to change(ClockIn, :count).by(1)
                .and change(ClockInSummary, :count).by(0)

                clock_in = ClockIn.where(user_id: user.id).last
                expect(clock_in.event_type).to eq("sleep_end")
                expect(clock_in.event_time).to eq(local_time + 8.hours + 7.days)
                expect(clock_in.schedule_date).to eq(local_time.to_date)


                summary = ClockInSummary.order(id: :desc).where(user_id: user.id).first

                expect(summary.status).to eq("completed")
                expect(summary.schedule_date).to eq(local_time.to_date)
                expect(summary.sleep_start).to eq(local_time)
                expect(summary.sleep_end).to eq(local_time + 8.hours + 7.days)
                expect(summary.sleep_duration_minute).to eq(10_560)
            end
          end
        end
      end
    end
  end
end
