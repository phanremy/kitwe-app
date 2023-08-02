# frozen_string_literal: true

class CreateProfileEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :profile_events do |t|
      t.references :profile, null: false, foreign_key: true
      t.references :event, null: false, foreign_key: true

      t.timestamps
    end
  end
end
