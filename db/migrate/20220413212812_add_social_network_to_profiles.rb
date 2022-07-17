# frozen_string_literal: true

# top level documentation for AddSocialNetworkToProfiles
class AddSocialNetworkToProfiles < ActiveRecord::Migration[7.0]
  def change
    add_column :profiles, :tiktok_url, :string
    add_column :profiles, :twitter_url, :string
    add_column :profiles, :linkedin_url, :string
  end
end
