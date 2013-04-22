class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.datetime  :start_time
      t.datetime  :end_time
      t.string    :slug

      t.timestamps
    end
  end
end
