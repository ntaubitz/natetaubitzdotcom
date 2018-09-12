class SettingsController < ApplicationController
  before_action :login_required
  before_action :set_alerts

  # GET /settings
  def index
    @active_tab = params.fetch(:active_tab, :security)
  end

  # POST /settings/change_password
  def change_password
    case current_user.change_password(change_password_params)
      when :invalid_current_password
        @alerts << {
          type: :danger,
          title: 'Password Mismatch',
          text: 'The password you entered does not match your current password'
        }
      when :confirmation_invalid
        @alerts << {
          type: :danger,
          title: 'Password Mismatch',
          text: 'The confirmation password does not match your new password'
        }
      when :password_invalid
        @alerts << {
          type: :danger,
          title: 'New Password Invalid',
          text: current_user.errors.messages.first.second.first
        }
      else
        @alerts << {
          type: :success,
          title: 'Password Changed',
          text: 'Your password has been changed'
        }
    end

    @active_tab = :security
    render 'index'
  end

  private

  def set_alerts
    @alerts = []
  end

  def change_password_params
    params.permit(:current_password, :new_password, :confirm_password)
  end
end