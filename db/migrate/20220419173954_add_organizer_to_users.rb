# frozen_string_literal: true

class AddOrganizerToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :is_organizer, :boolean, null: false, default: false
  end
end
