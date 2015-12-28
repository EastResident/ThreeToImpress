class window.Three_app
	constructor: ->
		@scene = new THREE.Scene()
		# THREE.PerspectiveCamera(画角, 縦横比, クリッピング手前, クリッピング奥)
		@camera = new THREE.PerspectiveCamera(75, window.innerWidth / window.innerHeight, 0.1, 1000)
		# カメラの位置を設定
		@camera.position.z = 5
		# OrbitControls用の処理
		@controls = new THREE.OrbitControls(@camera)

		@renderer = new THREE.WebGLRenderer()
		@renderer.setSize( window.innerWidth, window.innerHeight )

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
