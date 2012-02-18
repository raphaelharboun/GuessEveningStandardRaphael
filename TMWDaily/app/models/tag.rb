class Tag < ActiveRecord::Base
	has_and_belongs_to_many :headlines

	scope :current, lambda { where("created_at >= ?", Headline.get_start_date) }

end
