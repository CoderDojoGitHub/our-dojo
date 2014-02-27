class AddClassSizeToEvents < ActiveRecord::Migration
  def change
    add_column :events, :class_size, :integer
  end
end
