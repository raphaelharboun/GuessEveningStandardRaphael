class CreateHeadlines < ActiveRecord::Migration
  def change
    create_table :headlines do |t|
      t.string :name
      t.integer :rank

      t.timestamps
    end
  end
end
