class CreateLessons < ActiveRecord::Migration
  def change
    create_table :lessons do |t|
      t.string  :title,       null: false
      t.text    :summary,     null: false
      t.string  :repository,  null: false

      t.timestamps
    end
  end
end
