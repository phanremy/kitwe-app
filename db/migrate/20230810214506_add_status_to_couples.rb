# frozen_string_literal: true

class AddStatusToCouples < ActiveRecord::Migration[7.0]
  def change
    add_column :couples, :status, :string, default: 'in_a_relationship'
  end
end
