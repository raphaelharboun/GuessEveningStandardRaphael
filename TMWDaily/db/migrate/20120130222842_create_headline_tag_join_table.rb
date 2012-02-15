class CreateHeadlineTagJoinTable < ActiveRecord::Migration
  def up
  	create_table :headlines_tags, :id => false do |t|
  		t.integer :headline_id
  		t.integer :tag_id
  	end
  end

  def down
  	drop_table :headlines_tags
  end
end
