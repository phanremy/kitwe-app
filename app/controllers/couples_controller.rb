# frozen_string_literal: true

class CouplesController < ApplicationController
  include Tokenizer

  load_and_authorize_resource

  def index
    @profile = Profile.find(params[:profile_id])
    @couples = @profile.couples
  end

  def new
    @couple = Couple.new
  end

  def create
    @couple = Couple.new(couple_params)
    @couple.profile1_id = params[:profile_id] if params[:profile_id]
    if @couple.save
      flash[:success] = I18n.t('couples.create_success')
      redirect_path
    else
      flash.now[:error] = @couple.errors.full_messages
      render_flash
    end
  end

  def edit; end

  def update
    if @couple.update(couple_params)
      flash.now[:success] = I18n.t('couples.update_success')
      redirect_path
    else
      flash.now[:error] = @couple.errors.full_messages
      render_flash
    end
  end

  def destroy
    if @couple.children.count.positive?
      flash.now[:error] = I18n.t('couples.with_children_error')
      render_flash
    elsif @couple.destroy
      flash[:success] = I18n.t('couples.destroy_success')
      redirect_path
    else
      flash.now[:error] = I18n.t('general_error')
      render_flash
    end
  end

  private

  def current_ability
    @current_ability ||= ::Ability.new(current_user)
  end

  def couple_params
    params.require(:couple).permit(:profile1_id, :profile2_id, :creator_id)
  end

  def redirect_path
    if params[:profile_id]
      redirect_to profile_path(params[:profile_id], profile_id: nil)
    else
      redirect_to root_path
    end
  end
end
