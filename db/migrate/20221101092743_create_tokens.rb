# frozen_string_literal: true

class CreateTokens < ActiveRecord::Migration[7.0]
  def change
    create_table :tokens do |t|
      t.references :user, foreign_key: true, optional: true
      t.string :category
      t.string :name
      t.text :content

      t.timestamps
    end
  end
end
