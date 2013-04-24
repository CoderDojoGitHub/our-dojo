class CreateRegistrants < ActiveRecord::Migration
  def change
    create_table :registrants do |t|
      t.string :email

      t.timestamps
    end
  end
end
