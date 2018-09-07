class WorkLog < ApplicationRecord
  JOBS = {
    mailshake: 'mailshake'
  }.freeze

  belongs_to :user

  validates :job, presence: true

  scope :for_job, -> (job) { where(job: job) }
  scope :most_recent, -> (limit) { order(created_at: :desc).limit(limit) }
end