class SlidesController < ApplicationController
	protect_from_forgery except: :create

	def new
		@new_slide = Slide.new
	end
	def create
		attr = params.require(:slide).permit(:file)

		@new_slide = Slide.new image: attr[:file]
		@new_slide.save
		redirect_to 'new'
	end

end
