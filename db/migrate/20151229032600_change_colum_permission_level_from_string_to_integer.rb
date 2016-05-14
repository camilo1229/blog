class ChangeColumPermissionLevelFromStringToInteger < ActiveRecord::Migration
  def change
  	remove_column :users, :permission_level, :string
  	remove_column :users, :permissions_level, :integer
  	add_column :users, :permission_level, :integer, default: 1
  end
end
