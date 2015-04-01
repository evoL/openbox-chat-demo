class CreateChatTokens < ActiveRecord::Migration
  def change
    create_table :chat_tokens do |t|
      t.references :user
      t.references :session
      t.datetime :expires_at
      t.string :token
    end
  end
end
