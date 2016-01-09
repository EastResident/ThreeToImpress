class AddPositionToSlide < ActiveRecord::Migration
  def change
  	add_column :slides, :position_x, :float
  	add_column :slides, :position_y, :float
  	add_column :slides, :position_z, :float
  end
end
