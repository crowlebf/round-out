class EventsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    if params[:query]
      @events = Event.text_seach(params[:query]).upcoming.order(created_at: :desc)
    elsif params[:id] == "today"
      @events = Event.upcoming.where("starts_at <= ?",  DateTime.now.end_of_day).order(starts_at: :asc)
    elsif params[:id] == "week"
      @events = Event.upcoming.where("starts_at <= ?",  DateTime.now.end_of_week(start_day = :monday)).order(starts_at: :asc)
    elsif params[:id] == "month"
      @events = Event.upcoming.where("starts_at <= ?",  DateTime.now.end_of_month).order(starts_at: :asc)
    else
      @events = Event.upcoming.order(created_at: :desc)
    end
  end

  def show
    @event = Event.find(params[:id])
    @memberships = Membership.where(event_id: @event.id)
    if user_signed_in?
      gon.user = current_user.first_name
    end
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
    @event.set_start_date_time
    if @event.starts_at <= Time.now
      flash[:error] = "Event cannot occur in the past"
      render :new
    else
      if @event.save
        @membership = Membership.create(user_id: current_user.id, event_id: @event.id, approved: true)
        @membership.save
        flash[:notice] = "Event added!"
        redirect_to event_path(@event)
      else
        flash.now[:errors] = @event.errors.full_messages.join(". ")
        render :new
      end
    end
  end

  def update
    @event = Event.find(params[:id])
    if @event.user == current_user
      if @event.update_attributes(event_params)
        flash[:notice] = 'Event updated successfully.'
        redirect_to event_path(@event)
      else
        flash.now[:error] = @event.errors.full_messages.join(". ")
        render :edit
      end
    else
      flash[:error] = "You don't have access to this form."
      redirect_to event_path(@event)
    end
  end

  def destroy
    @event = Event.find(params[:id])
    if @event.user == current_user
      @event = Event.find(params[:id]).destroy
      flash[:notice] = "Event deleted"
      redirect_to events_path
    else
      flash[:error] = "You don't have permission to delete this event."
      redirect_to events_path
    end
  end

  private

  def event_params
    params.require(:event).permit(:user_id, :title, :description, :starts_at, :start_date, :start_time, :address, :address_secondary, :city, :state, :picture, :longitude, :latitude, :needed)
  end

  def membership_params
  params.require(:membership).permit(:user, :event, :approved)
  end
end
