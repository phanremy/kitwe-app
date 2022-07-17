# frozen_string_literal: true

# top level documentation for CreateEvents
class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.string :category
      t.string :privacy, default: 'public', null: false
      t.date :date

      t.timestamps
    end

    add_reference :events, :creator,
                  foreign_key: { to_table: :users }

    change_column_null :events, :creator_id, false
  end
end
