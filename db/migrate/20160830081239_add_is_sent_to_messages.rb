class AddIsSentToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :is_sent, :boolean, default: false
    add_index :messages, :is_sent
  end
end
