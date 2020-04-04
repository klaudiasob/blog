# frozen_string_literal: true

class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.integer :recipient_id, index: true
      t.references :message, foreign_key: true, index: true
      t.boolean :read

      t.timestamps
    end
  end
end
