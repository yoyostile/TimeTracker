class TimeRange < ActiveRecord::Base

  belongs_to :activity

  before_create :set_started_at

  scope :unfinished, -> { where(finished_at: nil) }
  scope :finished, -> { where('finished_at IS NOT NULL') }

  def finished?
    finished_at?
  end

  def finish!
    update_attribute(:finished_at, DateTime.now) unless finished_at
  end

  def duration
    finished_at - started_at if finished?
  end

  private

  def set_started_at
    self.started_at = DateTime.now
  end

end
