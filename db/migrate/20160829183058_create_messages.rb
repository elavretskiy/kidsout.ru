class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.belongs_to :sender, null: false
      t.belongs_to :recipient, null: false
      t.string :body, null: false
      t.boolean :is_read, default: false

      t.timestamps null: false
    end

    add_index :messages, :is_read
    add_index :messages, :sender_id
    add_index :messages, :recipient_id
  end
end
