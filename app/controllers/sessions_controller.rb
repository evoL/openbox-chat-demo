class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(name: session_params.fetch(:user_name))

    if user
      session[:user_id] = user.id
      redirect_to root_path, notice: 'Logged in'
    else
      redirect_to new_session_path, alert: 'User not found'
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to root_path, notice: 'Logged out'
  end

  private
  def session_params
    params.require(:session).permit(:user_name)
  end
end
