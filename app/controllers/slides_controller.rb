class SlidesController < ApplicationController
	protect_from_forgery except: :create

	def new
		@user = User.find(current_user.id)
		@new_slide = Slide.new

		gon.now_slide = @user.slides.first.image.url.to_s if @user.slides.count.to_i > 0

	end
	def create
		attr = params.require(:slide).permit(:file)
		@new_slide = Slide.new image: attr[:file], user_id: current_user.id
		@new_slide.save

		# gon.now_slide = @new_slide.image.url.to_s
		redirect_to 'new'
	end

end
