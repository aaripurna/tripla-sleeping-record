module Api
  module V1
    class UsersController < ApiController
      def create
        @user = User.new(user_create_params)
        if @user.save
          render json: UserSerializer.new(object: @user), status: :created
        else
          render json: ErrorSerializer.new(@user.errors), status: :unprocessable_entity
        end
      end

      def show
        user = User.find(params[:id])
        render json: UserSerializer.new(object: user), status: :ok
      end

      private
      def user_create_params
        params.permit(:name)
      end
    end
  end
end
