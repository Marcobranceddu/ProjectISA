# frozen_string_literal: true

class CreateBlacklist < ActiveRecord::Migration[7.0]
  def change
    create_table :blacklists, id: false do |t|
      t.belongs_to :organizer
      t.belongs_to :user
    end
  end
end
