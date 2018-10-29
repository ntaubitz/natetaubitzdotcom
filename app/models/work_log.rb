class WorkLog < ApplicationRecord
  JOBS = {
    mailshake: 'mailshake'
  }.freeze

  belongs_to :user

  validates :job, presence: true

  scope :for_job, -> (job) { where(job: job) }
  scope :most_recent, -> (limit) { order(created_at: :desc).limit(limit) }
  scope :finished, ->  { where('started IS NOT NULL AND ended IS NOT NULL') }
  scope :not_finished, ->  { where('ended is NULL') }
  scope :billed, -> (billed)  { where(billed: billed) }
  scope :between, -> (beginning, ending)  { where('started >= ?', beginning).where('ended <= ?', ending) }

  def is_open?
    self.ended.nil?
  end

  def finish
    if self.ended.nil?
      self.ended = Time.now
      save
    end
  end

  def hours_logged
    (self.ended - self.started) / (60*60).round(2)
  end

  def self.history(user)
    history = []
    current_date = DateTime.now
    (0..12).each do |months_back|
      date = current_date - months_back.months
      period_begin = date.beginning_of_month.beginning_of_day
      period_end = date.end_of_month.end_of_day
      # Get the logs in the current month
      logs = user.work_logs.billed(true).between(period_begin, period_end)
      if logs.count > 0
        history << {
          period_begin: period_begin,
          period_end: period_end,
          billed_hours: logs.collect{|l| l.hours_logged}.sum.round(2),
          logs: logs
        }
      end
    end
    history
  end

  def self.unbilled_hours(job)
    WorkLog.for_job(job).finished.billed(false).collect{|wl| wl.hours_logged}.sum
  end
end