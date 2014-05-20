class Activity < ActiveRecord::Base

  acts_as_taggable

  before_create :set_started_at

  def as_json(options={})
    super(only: [ :name, :started_at, :finished_at, :notes ])
  end

  private

  def set_started_at
    self.started_at = DateTime.now
  end
end
