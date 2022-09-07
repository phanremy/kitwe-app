# frozen_string_literal: true

class AddCreatorIdToCouples < ActiveRecord::Migration[7.0]
  def change
    add_reference :couples, :creator,
                  foreign_key: { to_table: :users }

    Couple.where(creator_id: nil).each do |couple|
      couple.update!(creator_id: couple.profile1.creator_id)
    end
  end
end
