require 'open-uri'

class HeadlinesController < ApplicationController

	before_filter :authenticate_user!, :except => [:new, :index, :show]

	# GET /
	# GET /headlines
	def new
		@headline = Headline.new
		retrieve_index_infos
	end

	# POST /
	# POST /headlines
	def create
		@headline = current_user.headlines.build params[:headline]
		retrieve_index_infos
		if @headline.save then
			flash[:notice] = "Headline saved"
			redirect_to me_headlines_path
		else
			render :action => "new"
		end
	end

	# GET /user/:id/headlines
	def index
		begin
			@user = User.find(params[:id])
		rescue
			render :text => "User not found" and return
		end
		@headlines = @user.headlines.order("created_at DESC")
		current = @headlines.select { |h| h.created_at >= Headline.get_start_date }
		unless current.empty?
			@current_headline = current.first
			@headlines = @headlines.delete_if { |h| h.created_at >= Headline.get_start_date}
		end
	end

	# GET /me/headlines
	def me_index
		@headlines = current_user.headlines.order("created_at DESC")
		current = @headlines.select { |h| h.created_at >= Headline.get_start_date }
		unless current.empty?
			@current_headline = current.first
			@headlines = @headlines.delete_if { |h| h.created_at >= Headline.get_start_date}
		end
		render :action => "index"
	end

	# GET /me/current
	def show_current
		if @current_headline = current_user.headlines.current.first then
			@statistics = @current_headline.get_statistics
		else
			redirect_to "/me/headlines"
		end
	end

	# GET /user/:id/headlines/:id
	def show
		if params[:user_id] then
			render :text => "public headline"
		elsif current_user
			render :text => "private headline"
		else
			redirect_to user_session_path
		end
	end


	####
	#Functions
	####

	def retrieve_index_infos
		@last_devine_headlines = DevineUser.first.get_last_headlines(10)
		@twitter_trends = get_twitter_trends(44418)
		#@twitter_trends = ["Twitt1", "Twitt2", "Twitt3", "Twitt4", "Twitt5"]
	end

	def get_twitter_trends(woid)
		buffer = open("https://api.twitter.com/1/trends/#{woid}.json")
		if buffer.status.first == 420 then
			raise 'Twitter Rate Limite'
		end
		twitter = JSON.parse(buffer.read)
		return twitter[0]['trends']
	end


end
