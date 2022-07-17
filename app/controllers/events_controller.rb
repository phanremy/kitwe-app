# frozen_string_literal: true

# # top level documentation for EventsController
# class EventsController < ApplicationController
#   load_and_authorize_resource

#   before_action :authenticate_user!

#   def index
#     @events = Event.all
#   end

#   def show
#     @event = Event.find(params[:id])
#   end

#   def new
#     @event = Event.new
#   end

#   def create
#     @event = Event.new(event_params)
#     if @event.save
#       flash[:success] = 'Event successfully created'
#       redirect_to @event
#     else
#       flash.now[:error] = @event.errors.full_messages
#       render :new
#     end
#   end

#   def edit; end

#   def update
#     if @event.update(event_params)
#       # ProfileEvent.find_or_create
#       flash.now[:success] = 'Event was successfully updated'
#       redirect_to @event
#     else
#       flash.now[:error] = @event.errors.full_messages
#       render :edit
#     end
#   end

#   def destroy
#     if @event.destroy
#       flash[:success] = 'Event was successfully deleted.'
#       redirect_to events_path
#     else
#       flash.now[:error] = 'Something went wrong'
#       redirect_to @event
#     end
#   end

#   private

#   def current_ability
#     @current_ability ||= ::Ability.new(current_user)
#   end

#   def set_event
#     @event = Event.find(params[:id])
#   end

#   def event_params
#     params.require(:event).permit(Event::FORM_ATTRIBUTES)
#   end
# end
