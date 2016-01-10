@slide_object = []
@three_object = []
@slide_count = 0

three_app_controls = new Three_app
three_app_controls.readbody()
window.onmousedown = (e) ->
	projector = new THREE.Projector()
	rect = e.target.getBoundingClientRect()

	mouseX = e.clientX - rect.left
	mouseY = e.clientY - rect.top
	mouseX = (mouseX / window.innerWidth) * 2 - 1
	mouseY = -(mouseY / window.innerHeight) * 2 + 1

	vector = new THREE.Vector3(mouseX, mouseY, 1)
	projector.unprojectVector(vector, three_app_controls.camera)
	ray = new THREE.Raycaster(three_app_controls.camera.position, vector.sub(three_app_controls.camera.position).normalize())

	count = 0
	for object in @three_object
		if(ray.intersectObject(object).length > 0)
			three_app_controls.transctrl.detach()
			three_app_controls.transctrl.attach(@three_object[count])

		count += 1

@set_translate = ->
	three_app_controls.transctrl.setMode("translate")
@set_rotate = ->
	three_app_controls.transctrl.setMode("rotate")
@set_scale = ->
	three_app_controls.transctrl.setMode("scale")

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
	three_app_controls.scene.add(@three_object[@slide_count])

	# three_app_controls.transctrl.attach(@three_object[@slide_count])
  # t.transctrl.update()

# 描画ループ
renderloop = ->
	requestAnimationFrame( renderloop )
	three_app_controls.controls.update()
	three_app_controls.renderer.render( three_app_controls.scene, three_app_controls.camera )

renderloop()