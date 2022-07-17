# frozen_string_literal: true

# top level documentation for AddAddressWeddingKidsToProfiles
class AddAddressWeddingKidsToProfiles < ActiveRecord::Migration[7.0]
  def change
    add_column :profiles, :address, :string
    add_column :profiles, :address_privacy, :string, default: 'public', null: false
    add_column :profiles, :wedding_date, :date
    add_column :profiles, :wedding_date_privacy, :string, default: 'public', null: false
    add_column :profiles, :kids, :string
    add_column :profiles, :kids_privacy, :string, default: 'public', null: false
  end
end
