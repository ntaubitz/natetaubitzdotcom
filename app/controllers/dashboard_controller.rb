class DashboardController < ApplicationController
  before_action :login_required
  before_action :set_alerts

  # GET /dashboard
  def index

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
    if blog_post_params[:subject].blank? || blog_post_params[:markup].blank?
      @alerts << {
        type: :danger,
        title: 'Oh Snap!',
        text: "please supply some bloggness"
      }
    else
      BlogPost.new(
        user: current_user,
        subject: blog_post_params[:subject],
        markup: blog_post_params[:markup]
      ).save
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
    params.permit(:subject, :markup)
  end
end