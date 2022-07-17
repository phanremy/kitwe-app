# frozen_string_literal: true

# top level documentation for CreateFriendships
class CreateFriendships < ActiveRecord::Migration[7.0]
  def change
    create_table :friendships do |t|
      t.string :status, default: 'requested', null: false

      t.timestamps
    end

    add_reference :friendships, :requester,
                  foreign_key: { to_table: :users }

    add_reference :friendships, :addressee,
                  foreign_key: { to_table: :users }

    add_reference :friendships, :specifier,
                  foreign_key: { to_table: :users }
  end
end
