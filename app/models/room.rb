#encoding: utf-8 
class Room < ActiveRecord::Base
	# One (user) to many (rooms) relationship
	belongs_to :user

	validates_presence_of :title, :location, :description
	validates_length_of :description, minimum: 30, allow_blank: false

	def complete_name
		"#{title}, #{location}"
	end
end 