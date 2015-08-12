#encoding: utf-8 
class Room < ActiveRecord::Base
	# One room has many reviews
	has_many :reviews, dependent: :destroy
	has_many :reviewed_rooms, through: :reviews, source: :room
	# Reference of the user for the room
	belongs_to :user

	validates_presence_of :title, :location, :description
	validates_length_of :description, minimum: 30, allow_blank: false

	def complete_name
		"#{title}, #{location}"
	end
end 