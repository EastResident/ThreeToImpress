# slide_object = []
slide_count = 0

t = new Three_app
t.readbody()

@arrangement = ->
	positionx = 0
	positiony = 0
	positionz = 0
	path = window.image_path
	width = window.image_width / 100
	height = window.image_height / 100

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