class CreateChatSessions < ActiveRecord::Migration
  def change
    create_table :chat_sessions do |t|
      t.string :opentok_id, null: false
      t.integer :users, array: true
    end

    add_index :chat_sessions, :users
  end
end
