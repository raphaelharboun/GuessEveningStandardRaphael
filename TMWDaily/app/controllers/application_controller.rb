class ApplicationController < ActionController::Base
  protect_from_forgery
  rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found

  def after_sign_in_path_for(resource)
  	root_path
  end

  def record_not_found
  	render :text => "404 Not Found", :status => 404
  end
  
end
