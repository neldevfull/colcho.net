class Rooms::BaseController < ApplicationController
	
	before_filter :require_authentication

	private 

	def room
		@room =|| Room.find(params[:room_id])
	end

	def review_params
		params.require(:review).permit(:points)
	end

end