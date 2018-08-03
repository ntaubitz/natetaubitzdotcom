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

  # GET /react
  def react

  end

  private

  def contact_params
    params.permit(:email, :note)
  end
end