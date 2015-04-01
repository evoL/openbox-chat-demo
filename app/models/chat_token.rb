class ChatToken < ActiveRecord::Base
  belongs_to :user
  belongs_to :session, class_name: 'ChatSession'
end
