class window.SlideObject
	constructor: (slide_info) ->
		@image_path = slide_info["image_path"]
		@image_pos_x = slide_info["image_pos_x"]
		@image_pos_y = slide_info["image_pos_y"]
		@image_pos_z = slide_info["image_pos_z"]
		@image_height = slide_info["image_height"]
		@image_width = slide_info["image_width"]

class window.Three_app
	constructor: ->
		@scene = new THREE.Scene()
		# THREE.PerspectiveCamera(画角, 縦横比, クリッピング手前, クリッピング奥)
		@camera = new THREE.PerspectiveCamera(90, window.innerWidth / window.innerHeight, 0.1, 1000)
		# カメラの位置を設定
		@camera.position.z = 10

		@renderer = new THREE.WebGLRenderer()
		@renderer.setSize( window.innerWidth, window.innerHeight )
		@renderer.setClearColor(0xeeeeee, 1);
		# OrbitControls用の処理
		@controls = new THREE.OrbitControls(@camera,@renderer.domElement)
		@geometry = new THREE.SphereGeometry(0.5)
		@material = new THREE.MeshBasicMaterial( { color: 0x000000 } )
		@cube = new THREE.Mesh( @geometry, @material )
		@scene.add( @cube )
		# TransformControlsの初期化
		@transctrl = new THREE.TransformControls(@camera, @renderer.domElement)
		@transctrl.setSpace('local')
		@scene.add(@transctrl)
		@transctrl.setMode("translate")

		# 光源の追加
		# @directionalLight = new THREE.DirectionalLight( 0xffffff, 3 )
		# @directionalLight.position.z = 3
		# @scene.add( @directionalLight )

	# 描画領域を生成
	readbody: ->
		document.body.appendChild( @renderer.domElement )

@html_header = """
<!doctype html>

<html lang="en">
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=1024" />
  <meta name="apple-mobile-web-app-capable" content="yes" />
  <title>impress.js | presentation tool based on the power of CSS3 transforms and transitions in modern browsers | by Bartek Szopka @bartaz</title>

  <meta name="description" content="impress.js is a presentation tool based on the power of CSS3 transforms and transitions in modern browsers and inspired by the idea behind prezi.com." />
  <meta name="author" content="Bartek Szopka" />

  <link href="http://fonts.googleapis.com/css?family=Open+Sans:regular,semibold,italic,italicsemibold|PT+Sans:400,700,400italic,700italic|PT+Serif:400,700,400italic,700italic" rel="stylesheet" />

  <link href="css/impress-demo.css" rel="stylesheet" />

  <link rel="shortcut icon" href="favicon.png" />
  <link rel="apple-touch-icon" href="apple-touch-icon.png" />
</head>

<body class="impress-not-supported">

<div id="impress">
"""

@html_footer = """
</div>
<div class="hint">
  <p>Use a spacebar or arrow keys to navigate</p>
</div>
<script>
if ("ontouchstart" in document.documentElement) {
    document.querySelector(".hint").innerHTML = "<p>Tap on the left or right to navigate</p>";}
</script>
<script src="js/impress.js"></script>
<script>impress().init();</script>
</body>
</html>
"""

@slide_object = []
@three_object = []
@slide_count = 0

@three_app_controls = new Three_app

window.onmousedown = (e) ->
	projector = new THREE.Projector()
	rect = e.target.getBoundingClientRect()

	mouseX = e.clientX - rect.left
	mouseY = e.clientY - rect.top
	mouseX = (mouseX / window.innerWidth) * 2 - 1
	mouseY = -(mouseY / window.innerHeight) * 2 + 1

	vector = new THREE.Vector3(mouseX, mouseY, 1)
	projector.unprojectVector(vector, @three_app_controls.camera)
	ray = new THREE.Raycaster(@three_app_controls.camera.position, vector.sub(@three_app_controls.camera.position).normalize())

	count = 0
	for object in @three_object
		if(ray.intersectObject(object).length > 0)
			@three_app_controls.transctrl.detach()
			@three_app_controls.transctrl.attach(@three_object[count])

		count += 1

@set_translate = ->
	@three_app_controls.transctrl.setMode("translate")
@set_rotate = ->
	@three_app_controls.transctrl.setMode("rotate")
@set_scale = ->
	@three_app_controls.transctrl.setMode("scale")

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
	@three_app_controls.scene.add(@three_object[@slide_count])

	# @three_app_controls.transctrl.attach(@three_object[@slide_count])
  # t.transctrl.update()

@three_object_to_html = (object, slide_id, image) ->
	step = "<div id=\"slide#{slide_id}\" "
	step += "class=\"step\" "
	step += "data-x=\"#{object.position.x*100}\" "
	step += "data-y=\"#{-object.position.y*100}\" "
	step += "data-z=\"#{object.position.z*100}\" "
	step += "data-rotate-x=\"#{-180*object.rotation.x/Math.PI}\" "
	step += "data-rotate-y=\"#{180*object.rotation.y/Math.PI}\" "
	step += "data-rotate-z=\"#{-180*object.rotation.z/Math.PI}\" "
	step += "data-scale=\"#{object.scale.x}\">"
	step += "<img style=\"width:#{image.image_width}px;height:#{image.image_height}px\" "
	image_type = image.image_path[image.image_path.indexOf('.')..-1]
	step += "src=\"fig#{slide_id + 1}#{image_type}\">"
	step += "</div>"

	return step

@write_html = ->
	count = 0
	text = @html_header
	image_path = []
	for object in @three_object
		text += three_object_to_html(@three_object[count], count, @slide_object[count])
		image_path.push(@slide_object[count].image_path)
		count += 1
	text += @html_footer
	$.ajax(url: '/write_html', type: "POST", data:{html_text: text, image_path: image_path.join(",")})
	# alert(three_object_to_html(@three_object[0], 0, @slide_object[0]))
# 描画ループ
@renderloop = ->
	requestAnimationFrame( renderloop )
	@three_app_controls.controls.update()
	@three_app_controls.renderer.render( @three_app_controls.scene, @three_app_controls.camera )
