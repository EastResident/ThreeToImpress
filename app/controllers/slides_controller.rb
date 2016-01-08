class SlidesController < ApplicationController
	# protect_from_forgery except: :create

	def new
		@user = User.find(current_user.id)
		@new_slide = Slide.new
	end

	def read_image(user)
		@now_slide = user.slides.last.image.url.to_s
		image = FastImage.size('public/' + @now_slide)
		@image_height = image[1]
		@image_width = image[0]
	end
	def create
		attr = params.require(:slide).permit(:file)
		Slide.create image: attr[:file], user_id: current_user.id
		# @new_slide = Slide.new image: attr[:file], user_id: current_user.id
		# @new_slide.save
		@user = User.find(current_user.id)
		read_image(@user) if @user.slides.count.to_i > 0
		render layout: false
	end

end
