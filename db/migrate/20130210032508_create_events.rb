class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.datetime  :start_time, null: false
      t.datetime  :end_time
      t.string    :teacher_github_username, null: false
      t.string    :slug, null: false

      t.timestamps
    end
  end
end
