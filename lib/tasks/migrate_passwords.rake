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
	 		if user.valid?	 			
	 			puts "User correct"
	 			next
	 		end

	 		encripted_password = user.attributes["password"]
	 		user.password 			   = encripted_password
	 		user.password_confirmation = encripted_password
	 		puts "Success migrate"

	 		user.save!
	 	end
	end
end    