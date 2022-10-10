# frozen_string_literal: true

class AddSubCategoryToEvents < ActiveRecord::Migration[7.0]
  def change
    rename_column :events, :note, :sub_category
    add_column :events, :notes, :text
  end
end
