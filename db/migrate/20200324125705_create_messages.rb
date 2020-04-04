# frozen_string_literal: true

class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.text :body
      t.references :conversation, index: true
      t.integer :sender_id, index: true
      t.timestamps
    end
  end
end
