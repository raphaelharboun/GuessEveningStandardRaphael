module ApplicationHelper

	def resource_name
		:user
	end

	def resource
		@resource ||= User.new
	end

	def devise_mapping
		@devise_mapping ||= Devise.mappings[:user]
	end

	def nav_to(link, path)
		content_tag :li, :class => current_page?(path) ? "active" : "" do
			link_to link, path
		end
	end


end
