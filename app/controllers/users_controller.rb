class UsersController < ApplicationController
	def edit
		@user = User.find(params[:id]) 
	end

	def show
		@user = User.find(params[:id])
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)

		if @user.save
			redirect_to @user,
				notice: 'Success when registering' 
		else
			render action: :new 
		end
	end

	def update
		@user = User.find(params[:id])

		if @user.update(user_params)
			redirect_to @user,
				notice: 'Success when upgrading' 
		else
			reder actioni: :edit
		end 
	end

	private

	def user_params
		params.
			require(:user).
			permit(:full_name, :email, :password, 
				:password_confirmation, :location, :bio)
	end

end  