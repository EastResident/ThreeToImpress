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

		@geometry = new THREE.BoxGeometry( 1, 1, 1 )
		@material = new THREE.MeshBasicMaterial( { color: 0x00ff00 } )
		@cube = new THREE.Mesh( @geometry, @material )
		@scene.add( @cube )

		# 光源の追加
		# @directionalLight = new THREE.DirectionalLight( 0xffffff, 3 )
		# @directionalLight.position.z = 3
		# @scene.add( @directionalLight )

	# 描画領域を生成
	readbody: ->
		document.body.appendChild( @renderer.domElement )

