class PagesController < ApplicationController
  # GET /
  def overview

  end

  # GET /contact
  def contact
    @show_contact_alert = false
  end

  # POST /contact
  def contact_me
    ApplicationMailer.new.contact_email contact_params[:email], contact_params[:note]

    @show_contact_alert = true

    render 'contact'
  end

  # GET /code
  def code

  end

  # GET /login
  def login
    @errors = []
  end

  # GET /logout
  def logout
    reset_session
    redirect_to('/login')
  end

  # POST /login
  def authenticate
    @errors = []
    user = User.by_email(login_params[:email]).first
    if user.nil?
      @errors << {not_authenticated: 'Either your email or password was incorrect'}
    else
      if user.authenticate(login_params[:password])
        set_current_user(user)
        redirect_to('/dashboard')
        return
      else
        @errors << {not_authenticated: 'Either your email or password was incorrect'}
      end
    end
    render 'login'
  end

  private

  def contact_params
    params.permit(:email, :note)
  end

  def login_params
    params.permit(:email, :password)
  end
end