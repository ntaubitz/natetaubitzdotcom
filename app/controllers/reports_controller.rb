class ReportsController < ApplicationController
  before_action :login_required
  before_action :report_viewer_required

  # GET /reports
  def index
    @active_tab = params.fetch(:active_tab, :unbilled).to_sym

    if @active_tab == :unbilled
      @work_logs = work_log_user.work_logs.billed(false).order(created_at: :desc)
    else
      @history = WorkLog.history(work_log_user)
      @show_notes_index = params.fetch(:show_notes_index, -1).to_i
    end
  end
end