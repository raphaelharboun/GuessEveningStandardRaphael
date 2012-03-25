class Headline < ActiveRecord::Base
	belongs_to :user
	has_and_belongs_to_many :tags

	validates :user_id, :presence =>true
	validates :name, :presence => true
	validate :user_cant_save_multiples_headline_a_day, :on => :create

	scope :current, lambda { where("created_at >= ?", Headline.get_start_date) }
	scope :history, lambda { where("created_at < ?", Headline.get_start_date).order("created_at DESC") }

	after_create :create_tags_from_new_headline

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

	def self.get_random_current_headlines(n)
		Headline.current.order("random()").limit(n)
	end

	def extract_tags
		tags = self.name.split.delete_if { |item| item.size < 3 }
	end

	def get_statistics
		tag_count = Tag.current.sum("count").to_f
		average_length = (Headline.current.map { |h| h.tags.count }).inject { |sum,t| sum + t}
		return {:tag_count => tag_count, :average_length => average_length}
	end

	def to_param
		"#{id}-#{name.parameterize}"
	end

	###########
	# SCORING #
	###########

	def set_score
		set_score_by_tags
		set_score_by_headline_length
	end

	def set_score_by_tags
		tags.each do |tag|
			tag.headlines.each do |headline|
				if headline.user.type == 'User'
					headline.score += tag.name.length
					headline.save!
				end
			end
		end
	end

	def set_score_by_headline_length
		devine_tags_count = tags.count
		Headline.current.each do |headline|
			if headline.user.type == 'User'
				tags_count = headline.tags.count
				total = 3 - (devine_tags_count - tags_count).abs
				headline.score += total >= 0 ? total : 0
				headline.save!
			end
		end
	end

	private
		def create_tags_from_new_headline
			self.extract_tags.map{|item| item.capitalize}.each do |tag|
				resultTag = Tag.current.find_by_name(tag)
				if resultTag.nil? then
					  t = self.tags.create :name => tag, :count => 0
					  t.increment(:count) if self.user.type == 'User'
					  t.save
				else
					resultTag.increment(:count) if self.user.type == "User"
					resultTag.save
					self.tags << resultTag
				end
			end
		end

end
