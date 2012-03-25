class DevineUser < User

	def get_last_headlines(n)
		headlines.order("created_at DESC").limit(n).select("name, created_at")
	end

end