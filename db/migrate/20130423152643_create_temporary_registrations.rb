class CreateTemporaryRegistrations < ActiveRecord::Migration
  def change
    create_table :temporary_registrations do |t|
      t.integer   :registrant_id,       null: false
      t.integer   :number_of_students,  null: false
      t.integer   :event_id,            null: false
      t.string    :reference_token,     null: false
      t.datetime  :created_at,          null: false
    end
  end
end
