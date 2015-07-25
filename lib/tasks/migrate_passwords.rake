# encoding: utf-8
namespace :app do
	desc "My rake: encrypts all passwords 	" +
		  "tha were not proccessed in database"
	 task migrate_passwords: :environment do
	 	# If passwords are nil 
	 	unless User.attribute_names.include? "password"
	 		puts "The passwords already were migrated"
	 	end
	 	#Find user in users and check validate and if true make
	 	User.find_each do |user|
	 		puts "Migrating user: #{user.id} | #{user.full_name}"
	 		if !user.valid? || user.attribute_name["password"].blank?
	 			puts "User: ##{user.id} - #{user.full_name} invalid"
	 			puts "Required manual correction"
	 			next
	 		end

	 		encripted_password = user.attributes["password"]
	 		user.password 			   = encripted_password
	 		user.password_confirmation = encripted_password

	 		user.save!
	 	end
	end
end  