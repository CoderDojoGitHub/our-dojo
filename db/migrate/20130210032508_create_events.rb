class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.datetime  :start_time,  null: false
      t.datetime  :end_time
      t.string    :teacher_github_username, null: false
      t.integer   :lesson_id,   null: false
      t.string    :location,    null: false

      t.timestamps
    end
  end
end
