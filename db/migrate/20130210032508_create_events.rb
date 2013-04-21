class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string    :title
      t.datetime  :start_time
      t.datetime  :end_time
      t.integer   :state, default: 0
      t.datetime  :scheduled_at
      t.datetime  :invites_sent_at
      t.datetime  :opened_registration_at

      t.timestamps
    end
  end
end
