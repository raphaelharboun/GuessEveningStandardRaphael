class AddDefaultToHeadlineScore < ActiveRecord::Migration
  def change
  	change_column :headlines, :score, :integer, :default => 0
  end
end
