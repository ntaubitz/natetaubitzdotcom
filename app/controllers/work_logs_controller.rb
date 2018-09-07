class WorkLogsController < ApplicationController
  before_action :set_work_log, only: [:show, :update]
  before_action :verify_admin

  # GET /work_logs
  def index
    paginate(apply_scopes(current_user.work_logs))
  end

  private

  def set_work_log
    @work_log = WorkLog.find(params[:id])
  end
end
