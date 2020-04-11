extends Camera2D

const CAMERA_OFFSET = 100

func _ready():
	position = Vector2(CAMERA_OFFSET, 0)
	# Fazer a conexão do signal emitido pelo Player
	get_parent().connect("player_flipped", self, "_on_player_flipped")

func _on_player_flipped(to_right)->void:
	# Correção para deixar a camera sempre
	# posicionada mais a frente do player
	if not to_right:
		position = Vector2(CAMERA_OFFSET, 0)
	else:
		position = Vector2(-CAMERA_OFFSET, 0)
