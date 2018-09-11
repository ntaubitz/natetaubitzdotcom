module Authentication
  def current_user
    @current_user ||= User.find(session[:user_id]) unless session[:user_id].blank?
  end

  def anonymous_user
    @anonymous_user ||= User.find(Natetaubitzdotcom::Application.config.anonymous_user_id)
  end

  def work_log_user
    @work_log_user ||= User.find(Natetaubitzdotcom::Application.config.work_log_user_id)
  end

  def set_current_user(user)
    session[:user_id] = user.id
    @current_user = user
  end

  def login_required
    if current_user.nil?
      redirect_to('/login')
      true
    end
    false
  end

  def admin_required
    return true if login_required
    unless current_user.is_admin?
      redirect_to('/login')
      true
    end
    false
  end

  def report_viewer_required
    return true if login_required
    return false if current_user.is_admin?
    unless current_user.belongs_to?(:report_viewer)
      redirect_to('/')
      true
    end
    false
  end
end