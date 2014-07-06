class Activity < ActiveRecord::Base

  acts_as_taggable

  has_many :time_ranges

  after_create :set_started_at

  scope :finished, -> { joins(:time_ranges).where('time_ranges.finished_at IS NOT NULL') }
  scope :unfinished, -> { joins(:time_ranges).where('time_ranges.finished_at IS NULL') }

  def as_json(options={})
    super(only: [ :name, :started_at, :finished_at, :notes ])
  end

  def duration
    self.time_ranges.finished.map(&:duration).sum
  end

  def finished?
    self.time_ranges.unfinished.empty?
  end

  def finish!
    self.time_ranges.unfinished.first.try :finish!
  end

  def started_at
    self.time_ranges.order('started_at ASC').first.try :started_at
  end

  def finished_at
    self.time_ranges.order('finished_at DESC').first.try :finished_at if finished?
  end

  def resume!
    self.time_ranges.create if finished?
  end

  private

  def set_started_at
    self.time_ranges.create
  end
end
