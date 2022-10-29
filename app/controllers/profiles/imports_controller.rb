# frozen_string_literal: true

module Profiles
  class ImportsController < ApplicationController
    def new
      render turbo_stream: turbo_stream.append(
        :modal,
        partial: 'profiles/imports/new'
      )
    end

    def create
      # TODO: validate csv headers
      # TODO: CsvExport model working with token exchange
      return render_no_file if params[:file].nil?

      @result = Profiles::Import.new(params[:file], current_user)
      @result.call

      render_result
    end

    private

    def render_no_file
      flash.now[:error] = "No file attached"
      render_modal_flash
    end

    def render_result
      if @result.errors.count.positive?
        flash.now[:error] = @result.errors.to_sentence
      else
        flash.now[:success] = "Import Completed for #{@result.imported_profile_count} profiles"
      end
      render_modal_flash
    end
  end
end
