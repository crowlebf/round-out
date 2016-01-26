# class Api::V1::CommentsController < ActionController::Base
#   protect_from_forgery with: :null_session
#
#   def create
#     event = Event.find(params[:event_id])
#     user = current_user
#     comment = event.comment.new(comment_params)
#     comment.user = user
#     render json: comment
#   end
#
#   private
#   def comment_params
#     params.require(:comment).permit(:body, :event, :user)
#   end
# end

# class Api::V1::CommentsController < ActionController::Base
#   protect_from_forgery with: :null_session
#
#   def create
#     event = Event.find(params[:event_id])
#     user = current_user
#     comment = event.comment.new(comment_params)
#     comment.user = user
#     if comment.save
#       render json: :nothing, status: :created, location: api_v1_comments_path(comment)
#     else
#       render json: :nothing, status: :not_found
#     end
#   end
#
#   private
#   def comment_params
#     params.require(:comment).permit(:title, :content, :video_id)
#   end
# end
