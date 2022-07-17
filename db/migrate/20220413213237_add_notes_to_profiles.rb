# frozen_string_literal: true

# top level documentation for AddSocialNetworkToProfiles
class AddNotesToProfiles < ActiveRecord::Migration[7.0]
  def change
    add_column :profiles, :notes, :text
  end
end
