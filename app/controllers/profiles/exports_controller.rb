# frozen_string_literal: true

module Profiles
  class ExportsController < ApplicationController
    include Tokenizer
    # TODO: check permission

    def create
      return render_error unless params[:profile_ids] && acceptable_profile_ids_count

      @data = Profiles::Export.new(params[:profile_ids]).call
      @file_name = "kitwe_profiles_#{Time.current}.csv"
      create_token

      render turbo_stream: turbo_stream.append(
        :modal,
        partial: 'profiles/exports/create'
      )
    end

    private

    def create_token
      token = Token.create!(
        category: 'profile_import',
        user: current_user,
        name: "#{current_user.email}_#{@file_name}",
        content: @data
      )
      @tokenized_name = jwt_encode(token.name)
    end

    def acceptable_profile_ids_count
      params[:profile_ids].count.between?(1, 100)
    end

    def render_error
      flash.now[:alert] = 'You need to have between 1 to 100 filtered profiles'
      render_flash
    end
  end
end
