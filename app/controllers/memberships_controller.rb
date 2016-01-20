class MembershipsController < ApplicationController
  before_action :authenticate_user!

  def create
    @event = Event.find(params[:event_id])
    @membership = Membership.new(user_id: current_user.id, event_id: @event.id, approved: false)

    if @membership.save
      flash[:notice] = "Thank you for showing interest in #{@event.title}! You will be notified if you're asked to join this event."
      redirect_to event_path(@event)
    else
      flash.now[:errors] = @membership.errors.full_messages.join(". ")
      redirect_to event_path(@event)
    end
  end

  def update
    @membership = Membership.find(params[:id])
    @event = Event.find_by(id: @membership.event_id)

    @membership.update_attributes(approved: true)
    redirect_to event_path(@event)
  end

  def destroy
    @membership = Membership.find(params[:id])
    @event = Event.find_by(id: @membership.event)
    if @event.user == current_user
      unless @membership.user == current_user
        @membership.destroy
        flash[:notice] = "User removed from event."
        redirect_to event_path(@event)
      else
        flash[:notice] = "You can't remove yourself from an event."
        redirect_to event_path(@event)
      end
    else
      flash[:notice] = "You're not the creator of the event."
      redirect_to event_path(@event)
    end
  end

  private

  def membership_params
  params.require(:membership).permit(:user, :event, :approved)
  end
end
