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

      def unfollow
        follow = Follow.find_by!(follower_id: params[:follower_id], followee_id: params[:followee_id])

        if follow.destroy!
          head :ok
        end
      rescue ActiveRecord::RecordNotFound
        render json: ErrorSerializer.new([ ActiveModel::Error.new(OpenStruct.new, :followee_id, "not found") ]), status: :not_found
      end

      private

      def create_follow_params
        params.permit(:follower_id, :followee_id)
      end
    end
  end
end
