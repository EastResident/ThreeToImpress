class SlidesController < ApplicationController
	# protect_from_forgery except: :create

	def new
		@user = User.find(current_user.id)
		@new_slide = Slide.new(position_x: 0, position_y: 0, position_z: 0)
	end

	def read_image(user)
		@now_slide = user.slides.last
		@image_path = @now_slide.image.url.to_s
		@image_pos_x = @now_slide.position_x
		@image_pos_y = @now_slide.position_y
		@image_pos_z = @now_slide.position_z
		image = FastImage.size('public/' + @image_path)
		@image_height = image[1]
		@image_width = image[0]
	end
	def create
		attr = params.require(:slide).permit(:file, :position_x, :position_y, :position_z)

		Slide.create(
			image: attr[:file],
			user_id: current_user.id,
			position_x: attr[:position_x],
			position_y: attr[:position_y],
			position_z: attr[:position_z]
			)
		# @new_slide = Slide.new image: attr[:file], user_id: current_user.id
		# @new_slide.save
		@user = User.find(current_user.id)
		read_image(@user) if @user.slides.count.to_i > 0
		render layout: false
	end

end
