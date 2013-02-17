class CreateUsers < ActiveRecord::Migration
  def up
    create_table :users do |t|
      t.string   "name",                  :null => false
      t.string   "email", :default => "", :null => false
      t.datetime "created_at",            :null => false
      t.datetime "updated_at",            :null => false
      t.integer  "github_id"
      t.string   "github_identifier"
      t.string   "authentication_token"
    end

    add_index :users, :github_id, :unique => true
  end

  def down
    drop_table :users
  end
end