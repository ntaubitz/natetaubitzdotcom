class DashboardController < ApplicationController
  before_action :login_required
  before_action :set_alerts

  # GET /dashboard
  def index
    @active_blog_post = nil
    unless params.fetch(:blog_post_id, nil).nil?
      @active_blog_post = BlogPost.find params[:blog_post_id]
    end
  end

  # POST /dashboard/create_short_post
  def create_short_post
    if short_post_params[:post].blank?
      @alerts << {
        type: :danger,
        title: 'Oh Snap!',
        text: "please supply some thankfulness"
      }
    else
      ShortPost.new(user: current_user, text: short_post_params[:post]).save
      @alerts << {
        type: :success,
        title: 'done!',
        text: "you are thankful for #{short_post_params[:post]}"
      }
    end

    render 'index'
  end

  def create_blog_post
    post = BlogPost.create(user: current_user, subject: 'new post', markup: '<p>be positive</p>')
    redirect_to("/dashboard?blog_post_id=#{post.id}")
  end

  def save_blog_post
    @active_blog_post = BlogPost.find blog_post_params[:blog_post_id]
    if blog_post_params[:subject].blank? || blog_post_params[:markup].blank?
      @alerts << {
        type: :danger,
        title: 'Oh Snap!',
        text: "please supply some bloggness"
      }
    else
      @active_blog_post.subject = blog_post_params[:subject]
      @active_blog_post.markup = blog_post_params[:markup]
      @active_blog_post.published = blog_post_params[:published]
      @active_blog_post.save
      @alerts << {
        type: :success,
        title: 'done!',
        text: "you are thankful for posting #{blog_post_params[:subject]}"
      }
    end

    render 'index'
  end

  private

  def set_alerts
    @alerts = []
  end

  def login_required
    if current_user.nil?
      redirect_to('/login')
    end
  end

  def short_post_params
    params.permit(:post)
  end

  def blog_post_params
    params.permit(:blog_post_id, :subject, :markup, :published)
  end
end