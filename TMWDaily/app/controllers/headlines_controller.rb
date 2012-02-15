class HeadlinesController < ApplicationController
	before_filter :authenticate_user!, :except => [:new]

	def new
		@headline = Headline.new
	end

	def create
		@headline = current_user.headlines.build params[:headline]
		if @headline.save then
			render :text => "Headline saved"
		else
			render :action => "new"
		end
	end

end
