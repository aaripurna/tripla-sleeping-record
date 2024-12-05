module Api
  module V1
    class ClockInsController < ApiController
      include Pagination

      def create
        form = ClockInCreateForm.new(create_clock_in_params)

        if form.save
          render json: ClockInSerializer.new(form.clock_in).serializable_hash, status: :created
        else
          render json: ErrorSerializer.new(form.errors), status: :unprocessable_entity
        end
      end

      def index
        page = params[:page] || 1
        limit = params[:limit] || 32

        query = ClockIn.where(user_id: params[:user_id]).order(created_at: :desc)

        pagination, records = Pagination.new(request.path).paginate(query, page: page, limit: limit)

        options = { links: pagination.links.as_json, meta: { pagination: pagination.details } }

        render json: ClockInSerializer.new(records, options).serializable_hash, status: :ok
      end

      private

      def create_clock_in_params
        params.permit(:user_id, :event_type)
      end
    end
  end
end
