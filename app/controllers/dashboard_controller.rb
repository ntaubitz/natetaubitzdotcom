class DashboardController < ApplicationController
  before_action :admin_required
  before_action :set_alerts
  before_action :set_active_work_log, only: [:save_work_log, :finish_work_log]

  # GET /dashboard
  def index
    @active_tab = params.fetch(:active_tab, :short_posts).to_sym
    if @active_tab == :blog_posts
      @active_blog_post = nil
      unless params.fetch(:blog_post_id, nil).nil?
        @active_blog_post = BlogPost.find params[:blog_post_id]
      end
    elsif @active_tab == :work_log
      @active_work_log = nil
      unless params.fetch(:work_log_id, nil).nil?
        @active_work_log = WorkLog.find params[:work_log_id]
      end
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

    @active_tab = :short_posts

    render 'index'
  end

  def create_blog_post
    post = BlogPost.create(user: current_user, subject: 'new post', markup: '# be positive')
    redirect_to("/dashboard?blog_post_id=#{post.id}&active_tab=blog_posts")
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
      @active_blog_post.update(blog_post_params.except(:blog_post_id))
      @alerts << {
        type: :success,
        title: 'done!',
        text: "blog '#{blog_post_params[:subject]}' was updates'"
      }
    end

    @active_tab = :blog_posts

    render 'index'
  end

  def save_work_log
    @active_work_log.update(work_log_params.except(:work_log_id))
    if @active_work_log.valid?
      @alerts << {
        type: :success,
        title: 'done!',
        text: "work log updated"
      }
    else
      @alerts << {
        type: :danger,
        title: 'Oh Snap!',
        text: @active_work_log.errors.inspect
      }
    end

    render 'index'
  end

  def start_work_log
    log = WorkLog.create(user: current_user, job: WorkLog::JOBS.first.first, notes: '<ul><li></li></ul>', started: Time.now)
    redirect_to("/dashboard?work_log_id=#{log.id}&active_tab=work_log")
  end

  def finish_work_log
    if @active_work_log.finish
      @alerts << {
        type: :success,
        title: 'A job well done',
        text: 'Now, go have some fun.'
      }
    end

    render 'index'
  end

  private

  def set_alerts
    @alerts = []
  end

  def set_active_work_log
    @active_work_log = WorkLog.find(params[:work_log_id])
  end

  def short_post_params
    params.permit(:post)
  end

  def blog_post_params
    params.permit(:blog_post_id, :subject, :markup, :published, :category)
  end

  def work_log_params
    params.permit(:work_log_id, :job, :notes, :started, :ended, :billed)
  end
end