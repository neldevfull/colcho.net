class User < ActiveRecord::Base

	EMAIL_REGEXP = /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/ 

	validates_presence_of :email, :full_name, :location, :password
	validates_confirmation_of :password 
	validates_length_of :bio, minimun: 30, allow_blank: false
	validates_uniqueness_of :email 

	validate :email_format   

	private

	# This validation can be represented as follows
	# validates_format_of :email, with: EMAIL_REGEXP
	def email_format
		erros.add(:email, :invalid) unless email.match(EMAIL_REGEXP)
	end

end  