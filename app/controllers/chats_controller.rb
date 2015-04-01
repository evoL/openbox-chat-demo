class ChatsController < ApplicationController
  def show
    @user = User.find(params[:user_id])
  end

  private
  def chat_params
    params.permit(:user_id)
  end
end
