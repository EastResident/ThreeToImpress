@slide_object = []
@slide_count = 0

t = new Three_app
t.readbody()

@arrangement = (slide_object) ->
	positionx = slide_object.image_pos_x / 100
	positiony = slide_object.image_pos_y / 100
	positionz = slide_object.image_pos_z / 100
	path = slide_object.image_path
	width = slide_object.image_width / 100
	height = slide_object.image_height / 100

	geometry = new THREE.BoxGeometry(width, height, 0)
	image_texture = new THREE.ImageUtils.loadTexture(path)
	material = new THREE.MeshBasicMaterial({map: image_texture})
	slide_object = new THREE.Mesh(geometry, material)
	slide_object.castShadow = true
	slide_object.position.set(positionx,positiony,positionz)
	t.scene.add(slide_object)
	slide_count += 1

# 描画ループ
renderloop = ->
	requestAnimationFrame( renderloop )
	t.controls.update()
	t.renderer.render( t.scene, t.camera )

renderloop()