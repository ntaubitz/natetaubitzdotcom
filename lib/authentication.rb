module Authentication
  def current_user
    @current_user ||= User.find(session[:user_id]) unless session[:user_id].blank?
  end

  def set_current_user(user)
    session[:user_id] = user.id
    @current_user = user
  end
end