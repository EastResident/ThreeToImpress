@slide_object = []
@three_object = []
@slide_count = 0

t = new Three_app
t.readbody()

@arrangement = (_slide_object) ->
	positionx = _slide_object.image_pos_x / 100
	positiony = _slide_object.image_pos_y / 100
	positionz = _slide_object.image_pos_z / 100
	path = _slide_object.image_path
	width = _slide_object.image_width / 100
	height = _slide_object.image_height / 100

	geometry = new THREE.BoxGeometry(width, height, 0)
	image_texture = new THREE.ImageUtils.loadTexture(path)
	material = new THREE.MeshBasicMaterial({map: image_texture})
	@three_object[@slide_count] = new THREE.Mesh(geometry, material)
	@three_object[@slide_count].castShadow = true
	@three_object[@slide_count].position.set(positionx,positiony,positionz)
	t.scene.add(@three_object[@slide_count])

# 描画ループ
renderloop = ->
	requestAnimationFrame( renderloop )
	t.controls.update()
	t.renderer.render( t.scene, t.camera )

renderloop()