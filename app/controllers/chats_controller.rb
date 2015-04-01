class ChatsController < ApplicationController
  def show
    @user = User.find(params[:user_id])

    @api_key = ENV['TOKBOX_API_KEY']
    @session = ChatSession.for(@user, current_user)
    @token = @session.token_for(current_user)
  end

  private
  def chat_params
    params.permit(:user_id)
  end
end
