# frozen_string_literal: true

class AddDeceasedToProfiles < ActiveRecord::Migration[7.0]
  def change
    add_column :profiles, :deceased, :boolean, default: false
    add_column :profiles, :death_date, :date
  end
end
