module Api
  module V1
    class UsersController < ApiController
      include Pagination

      def create
        @user = User.new(user_create_params)
        if @user.save
          render json: UserSerializer.new(@user).serializable_hash, status: :created
        else
          render json: ErrorSerializer.new(@user.errors), status: :unprocessable_entity
        end
      end

      def show
        user = User.find(params[:id])
        render json: UserSerializer.new(user).serializable_hash, status: :ok
      rescue ActiveRecord::RecordNotFound
        render json: ErrorSerializer.new([ ActiveModel::Error.new(OpenStruct.new, :id, "not found") ]), status: :not_found
      end

      def update
        user = User.find(params[:id])

        if user.update(user_create_params)
          render json: UserSerializer.new(user).serializable_hash, status: :ok
        else
          render json: ErrorSerializer.new(user.errors), status: :unprocessable_entity
        end
      rescue ActiveRecord::RecordNotFound
        render json: ErrorSerializer.new([ ActiveModel::Error.new(OpenStruct.new, :id, "not found") ]), status: :not_found
      end

      def index
        paginator = Pagination.new(request.path)

        page = params[:page] || 1
        limit = params[:limit] || 32

        pagination, users = paginator.paginate(User.all, page: page, limit: limit)

        options = { links: pagination.links.as_json, meta: { pagination: pagination.details } }
        render json: UserSerializer.new(users, options), status: :ok
      end

      private
      def user_create_params
        params.permit(:name)
      end
    end
  end
end
