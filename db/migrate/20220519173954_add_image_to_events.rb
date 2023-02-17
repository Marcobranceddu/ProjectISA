# frozen_string_literal: true

class AddImageToEvents < ActiveRecord::Migration[7.0]
  def change
    add_column :events, :image, :string, null: false, default: false
  end
end
