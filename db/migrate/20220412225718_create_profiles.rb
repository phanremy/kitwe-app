# frozen_string_literal: true

# top level documentation for CreateProfiles
class CreateProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :profiles do |t|
      t.references :user, foreign_key: true, optional: true
      t.string :pseudo
      t.string :first_name
      t.string :first_name_privacy, default: 'public', null: false
      t.string :last_name
      t.string :last_name_privacy, default: 'public', null: false
      t.string :email
      t.string :email_privacy, default: 'public', null: false
      t.string :phone
      t.string :phone_privacy, default: 'public', null: false
      t.date :birth_date
      t.string :birth_date_privacy, default: 'public', null: false

      t.timestamps
    end

    add_reference :profiles, :creator,
                  foreign_key: { to_table: :users }

    change_column_null :profiles, :creator_id, false
  end
end
