extends Camera2D

const CAMERA_OFFSET = 100

var tilemap : TileMap

func _ready():
	tilemap = get_node("/root/Tests/TileMap")
	if tilemap == null:
		tilemap = get_node("/root/Game/TileMap")
	position = Vector2(CAMERA_OFFSET, 0)
	# Fazer a conexão do signal emitido pelo Player
	get_parent().connect("player_flipped", self, "_on_player_flipped")
	set_camera_limits()

func _on_player_flipped(to_right)->void:
	# Correção para deixar a camera sempre
	# posicionada mais a frente do player
	if not to_right:
		position = Vector2(CAMERA_OFFSET, 0)
	else:
		position = Vector2(-CAMERA_OFFSET, 0)

func set_camera_limits():
	var map_limits = tilemap.get_used_rect()
	var map_cellsize = tilemap.cell_size
	limit_left = map_limits.position.x * map_cellsize.x
	limit_right = map_limits.end.x * map_cellsize.x
	limit_top = map_limits.position.y * map_cellsize.y
#	limit_bottom = map_limits.end.y * map_cellsize.y
	# TODO: ajustar o limite do bottom quando o mapa estiver pronto
