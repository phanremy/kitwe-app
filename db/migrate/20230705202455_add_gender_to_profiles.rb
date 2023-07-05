# frozen_string_literal: true

class AddGenderToProfiles < ActiveRecord::Migration[7.0]
  def change
    add_column :profiles, :gender, :string
  end
end
