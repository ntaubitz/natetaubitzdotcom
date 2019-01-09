class PagesController < ApplicationController
  # GET /
  def overview
    @most_recent_blog_post = BlogPost.published(true).most_recent.first
  end

  # GET /vue
  def vue
  end

  # GET /blog
  def blog
    if params[:blog_post_id].blank?
      query = anonymous_user.blog_posts.published(true)
      unless params[:category].nil?
        query = query.for_category(params[:category])
      end
      query = query.most_recent
      params[:blog_post_id] = query.first.id
    end

    @active_blog_post = BlogPost.find params[:blog_post_id]
    params[:category] = @active_blog_post.category
    @page_title = "Nathan Taubitz: #{@active_blog_post.subject}"
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
        url = '/'
        url = '/reports' if user.belongs_to?(:report_viewer)
        url = '/dashboard' if user.is_admin?
        redirect_to(url)
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