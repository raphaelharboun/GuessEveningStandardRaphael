class AddDefaultToUserType < ActiveRecord::Migration
  def change
  	change_column :users, :type, :string, :default => 'User'
  end
end
