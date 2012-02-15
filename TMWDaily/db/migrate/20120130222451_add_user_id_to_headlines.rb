class AddUserIdToHeadlines < ActiveRecord::Migration
  def change
    add_column :headlines, :user_id, :integer

  end
end
