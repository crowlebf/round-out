class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [
    :new, :create, :edit, :update, :destroy]

  def create
    @event = Event.find(params[:event_id])
    @user = current_user
    @comment = @event.comments.new(comment_params)
    @comment.user = @user

    if @comment.save
      flash[:notice] = "Comment added successfully"
      redirect_to event_path(@event)
    else
      flash.now[:errors] = @comment.errors.full_messages.join(". ")
      render event_path(@event)
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    event = @comment.event
    @comment.destroy

    redirect_to event_path(event), notice: "Comment deleted"
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :event, :user)
  end
end
