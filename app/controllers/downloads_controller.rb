# frozen_string_literal: true

class DownloadsController < ApplicationController
  def create
    respond_to do |format|
      format.html
      format.csv { send_data params[:data], filename: params[:file_name] }
    end
  end
end
