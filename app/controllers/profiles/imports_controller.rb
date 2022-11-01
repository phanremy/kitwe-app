# frozen_string_literal: true

module Profiles
  class ImportsController < ApplicationController
    include Tokenizer

    def new
      render turbo_stream: turbo_stream.append(
        :modal,
        partial: 'profiles/imports/new'
      )
    end

    def create
      # TODO: validate csv headers
      # TODO: CsvExport model working with token exchange
      return render_no_inputs if params[:file].nil? && params[:token].blank?
      return render_wrong_token if wrong_token?

      @result = Profiles::Import.new(file: @token ? nil : params[:file],
                                     content: @token&.content,
                                     user: current_user)
      @result.call

      render_result
    end

    private

    def wrong_token?
      return if params[:token].blank?

      token_name = jwt_decode(params[:token])
      @token = Token.where(category: 'profile_import').find_by(name: token_name)
      @token.nil?
    end

    def render_wrong_token
      flash.now[:error] = "Token not valid"
      render_modal_flash
    end

    def render_no_inputs
      flash.now[:error] = "No file attached, nor token provided"
      render_modal_flash
    end

    def render_result
      if @result.errors.count.positive?
        flash.now[:error] = @result.errors.to_sentence
        render_modal_flash
      else
        flash.now[:success] = "Import Completed for #{@result.imported_profile_count} profiles"
        render turbo_stream: turbo_stream.update(
          :import_form,
          partial: 'profiles/imports/create'
        )
      end
    end
  end
end
