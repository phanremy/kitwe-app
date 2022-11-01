# frozen_string_literal: true

class AddPhotoUrlToProfiles < ActiveRecord::Migration[7.0]
  def change
    add_column :profiles, :photo_url, :string
  end
end
