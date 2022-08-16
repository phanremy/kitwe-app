# frozen_string_literal: true

class CreateParentProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :parent_profiles do |t|
      t.belongs_to :parent, foreign_key: { to_table: :profiles }, null: false
      t.belongs_to :profile, foreign_key: true, null: false

      t.index(%i[parent_id profile_id], unique: true)
      t.timestamps
    end
  end
end
