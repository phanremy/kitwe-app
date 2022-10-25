# frozen_string_literal: true

class AddCategoriesToProfile < ActiveRecord::Migration[7.0]
  def change
    add_column :profiles, :category, :string, default: ""

    add_index :profiles, :category
  end
end
