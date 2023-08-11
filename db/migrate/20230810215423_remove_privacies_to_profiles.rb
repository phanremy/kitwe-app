# frozen_string_literal: true

class RemovePrivaciesToProfiles < ActiveRecord::Migration[7.0]
  def change
    change_table :profiles, bulk: true do |t|
      t.remove :first_name_privacy, type: :string, default: 'public', null: false
      t.remove :last_name_privacy, type: :string, default: 'public', null: false
      t.remove :email_privacy, type: :string, default: 'public', null: false
      t.remove :phone_privacy, type: :string, default: 'public', null: false
      t.remove :birth_date_privacy, type: :string, default: 'public', null: false
      t.remove :address_privacy, type: :string, default: 'public', null: false
      t.remove :wedding_date_privacy, type: :string, default: 'public', null: false
      t.remove :kids_privacy, type: :string, default: 'public', null: false
    end
  end
end
