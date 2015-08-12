class Rooms::ReviewsController < Rooms::BaseController

	def create
		review = room.reviews.
			find_or_initialize_by(:user_id current_user.id)
			review.update!(review_params)
			head :ok
	end

	def update
		create
	end

end