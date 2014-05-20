class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.string    :name
      t.datetime  :started_at
      t.datetime  :finished_at
      t.text      :notes
      t.references :user
      t.timestamps
    end
  end
end
