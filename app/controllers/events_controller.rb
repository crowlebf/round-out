class EventsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
  #   if params[:id] == "nearby"
  #   put in conditions for events within 25 miles of user
  # else
    @events = Event.order(created_at: :desc)
  # end
  end

  def show
    @event = Event.find(params[:id])
    @memberships = Membership.where(event_id: @event.id)
  end

  def new
    @event = Event.new
  end

  def edit
    @event = Event.find(params[:id])
    if @event.user == current_user
      @event = Event.find(params[:id])
    else
      flash[:error] = "You don't have access to this form"
      redirect_to event_path(@event)
    end
  end

  def create
    @event = Event.new(event_params)
    @event.user = current_user
    if @event.save
      binding.pry
      @membership = Membership.create(user_id: current_user.id, event_id: @event.id, approved: true)
      @membership.save
      flash[:notice] = "Event added!"
      redirect_to event_path(@event)
    else
      flash.now[:errors] = @event.errors.full_messages.join(". ")
      render :new
    end
  end

  def update
    @event = Event.find(params[:id])
    if @event.user == current_user
      if @event.update_attributes(event_params)
        flash.now[:notice] = 'Event updated successfully.'
        redirect_to event_path(@event)
      else
        flash.now[:error] = @event.errors.full_messages.join(". ")
        render :edit
      end
    else
      flash.now[:error] = "You don't have access to this form."
      redirect_to event_path(@event)
    end
  end

  def destroy
    if event.user == current_user
      @event = Event.find(params[:id]).destroy
      flash.now[:notice] = "Event deleted"
      redirect_to events_path
    end
  end

  private

  def event_params
    params.require(:event).permit(:user_id, :title, :description, :starts_at, :start_date, :start_time, :address, :address_secondary, :city, :state, :picture, :longitude, :latitude, :full_address)
  end

  def membership_params
  params.require(:membership).permit(:user, :event, :approved)
  end
end
