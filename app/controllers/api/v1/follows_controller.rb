module Api
  module V1
    class FollowsController < ApiController
      def create
        follow = Follow.new(create_follow_params)
        if follow.save
          render json: FollowSerializer.new(follow).serializable_hash, status: :created
        else
          render json: ErrorSerializer.new(follow.errors), status: :unprocessable_entity
        end
      end

      private

      def create_follow_params
        params.permit(:follower_id, :followee_id)
      end
    end
  end
end
