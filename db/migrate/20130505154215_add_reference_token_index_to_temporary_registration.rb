class AddReferenceTokenIndexToTemporaryRegistration < ActiveRecord::Migration
  def change
    add_index :temporary_registrations, :reference_token, unique: true
  end
end
