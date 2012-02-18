class Headline < ActiveRecord::Base
	belongs_to :user
	has_and_belongs_to_many :tags

	validates :user_id, :presence =>true
	validates :name, :presence => true
	validate :user_cant_save_multiples_headline_a_day

	scope :current, lambda { where("created_at >= ?", Headline.get_start_date) }

	after_save :create_tags_from_new_headline

	def user_cant_save_multiples_headline_a_day
		if self.user
			unless self.user.headlines.current.empty?
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

	def self.get_current_headlines
		Headline.current
	end

	def self.get_ten_random_current_headlines
		Headline.current.order("random()").limit(10)
	end

	def extract_tags
		tags = self.name.split.delete_if { |item| item.size < 3 }
	end

	private
		def create_tags_from_new_headline
			self.extract_tags.map{|item| item.capitalize}.each do |tag|
				resultTag = Tag.current.find_by_name(tag)
				if resultTag.nil? then
					  self.tags.create :name => tag, :count => 1
				else
					resultTag.increment(:count)
					resultTag.save
					self.tags << resultTag
				end
			end
		end

end
