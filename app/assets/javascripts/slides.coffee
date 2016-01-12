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