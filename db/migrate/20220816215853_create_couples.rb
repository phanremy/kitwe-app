# frozen_string_literal: true

class CreateCouples < ActiveRecord::Migration[7.0]
  def change
    create_table :couples do |t|
      t.references :profile1, foreign_key: { to_table: :profiles }, null: false
      t.references :profile2, foreign_key: { to_table: :profiles }

      t.index(%i[profile1_id profile2_id], unique: true)
      t.timestamps
    end
  end
end
