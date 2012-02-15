class Headline < ActiveRecord::Base
	belongs_to :user
	has_and_belongs_to_many :tags

	validates :user_id, :presence =>true
	validates :name, :presence => true
	validate :user_cant_save_multiples_headline_a_day

	def user_cant_save_multiples_headline_a_day
		if self.user
			unless self.user.headlines.where("created_at >= ?", Headline.get_start_date).empty?
				errors.add :name, "User can't print two headline for the same issue"
			end
		end
	end

	def self.get_start_date
		startDate = DateTime.current.change :hour => 18
		if DateTime.now.hour < 18
			startDate = startDate - 1.day
		end
		return startDate
	end

	def extract_tags
		tags = self.name.split.delete_if { |item| item.size < 3 }
	end

end
