class Activity < ActiveRecord::Base

  acts_as_taggable

  before_create :set_started_at

  scope :finished, -> { where('finished_at IS NOT NULL') }

  def as_json(options={})
    super(only: [ :name, :started_at, :finished_at, :notes ])
  end

  def duration
    finished_at - started_at if finished?
  end

  def finished?
    started_at?
  end

  def finish!
    update_attribute(:finished_at, DateTime.now) unless finished_at
  end

  private

  def set_started_at
    self.started_at = DateTime.now
  end
end
