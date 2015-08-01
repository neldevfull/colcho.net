#encoding: utf-8 
class User < ActiveRecord::Base

	#default_scope -> { where('confirmed_at IS NOT NULL') }
	scope :most_recent, -> { order('created_at DESC') }
	scope :where_location, -> (location) { where(location: location) }   
	scope :confirmed, -> { where.not(confirmed_at: nil) }

	EMAIL_REGEXP = /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/ 

	validates_presence_of :email, :full_name, :location	
	validates_length_of :bio, minimum: 30, allow_blank: false
	validates_uniqueness_of :email 
	validates_format_of :email, with: EMAIL_REGEXP

	has_secure_password  	

	before_create do |user|
		user.confirmation_token = SecureRandom.urlsafe_base64
	end 

	def confirm!
		return if confirmed?

		self.confirmed_at = Time.current
		self.confirmation_token = '' 
		save! 
	end

	def confirmed?
		confirmed_at.present?
	end

	def self.authenticate(email, password)
		# *** Utilization condition 'if' ***
		# user = confirmed.find_by(email: email)
		# if user.present?
		# 	user.authenticate(password)
		# end
		# *** Utilization condition 'try' ***
		confirmed.find_by(email: email).
			try(:authenticate, password)
	end

	# validate :email_format   

	# private 

	# This validation can be represented as follows	
	# def email_format
	# 	erros.add(:email, :invalid) unless email.match(EMAIL_REGEXP)
	# end
	
end   