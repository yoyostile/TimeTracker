class AddTimeRanges < ActiveRecord::Migration
  def change
    create_table :time_ranges do |t|
      t.timestamps
      t.datetime :started_at
      t.datetime :finished_at
      t.references :activity
    end
    remove_column :activities, :started_at, :datetime
    remove_column :activities, :finished_at, :datetime
  end
end
