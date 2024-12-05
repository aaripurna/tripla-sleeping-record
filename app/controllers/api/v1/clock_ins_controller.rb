module Api
  module V1
    class ClockInsController < ApiController
      def create
        form = ClockInCreateForm.new(create_clock_in_params)

        if form.save
          render json: ClockInSerializer.new(form.clock_in).serializable_hash, status: :created
        else
          render json: ErrorSerializer.new(form.errors), status: :unprocessable_entity
        end
      end

      private

      def create_clock_in_params
        params.permit(:user_id, :event_type)
      end
    end
  end
end
