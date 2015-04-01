class ChatSession < ActiveRecord::Base
  include OpenTokSupport

  def self.for(user1, user2)
    user1_id = user1.respond_to?(:id) ? user1.id : user1
    user2_id = user2.respond_to?(:id) ? user2.id : user2

    user_array = [user1_id, user2_id].sort

    session = self.find_by("users = ARRAY[?]", user_array)
    unless session
      ot_session = opentok_client.create_session
      session = self.create(users: user_array, opentok_id: ot_session.session_id)
    end

    session
  end

  def token_for(user)
    token = ChatToken.where(user: user, session: self) \
            .where("chat_tokens.expires_at > ?", Time.now) \
            .last

    unless token
      expires_at = Time.now + 1.day
      ot_token = opentok_client.generate_token(self.opentok_id, {
        expire_time: expires_at.to_i,
        data: "id=#{user.id}"
      })

      token = ChatToken.create(
        user: user,
        session: self,
        expires_at: expires_at,
        token: ot_token
      )
    end

    token
  end
end
