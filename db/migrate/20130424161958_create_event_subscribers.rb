class CreateEventSubscribers < ActiveRecord::Migration
  def change
    create_table :event_subscribers do |t|
      t.string :email
      t.integer :event_id
      t.datetime :sent_at

      t.timestamps
    end
  end
end
