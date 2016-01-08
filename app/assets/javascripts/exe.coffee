@slide_object = []
@slide_count = 0

t = new Three_app
t.readbody()

@arrangement = ->
	positionx = 0
	positiony = 0
	positionz = -5
	geometry = new THREE.BoxGeometry(9,2,0)
	image_path = gon.now_slide
	image_texture = new THREE.ImageUtils.loadTexture(image_path)
	material = new THREE.MeshBasicMaterial({map: image_texture})
	slide_object[slide_count] = new THREE.Mesh(geometry, material)
	slide_object[slide_count].castShadow = true
	slide_object[slide_count].position.set(positionx,positiony,positionz)
	t.scene.add(slide_object[slide_count])
	slide_count += 1

# 描画ループ
renderloop = ->
	requestAnimationFrame( renderloop )
	t.controls.update()
	t.renderer.render( t.scene, t.camera )

renderloop()