class Tag < ActiveRecord::Base
	has_and_belongs_to_many :headlines

	scope :current, lambda { where("created_at >= ?", Headline.get_start_date) }
	

	def get_top_current(n)
		Tag.current.order("count DESC").limit(n)
	end

end
