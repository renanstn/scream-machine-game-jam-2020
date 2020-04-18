extends StaticBody2D

export(int) var id
onready var anim_player = $AnimationPlayer

func open_door(id_to_open):
	if id_to_open == id:
		open()

func _ready():
	anim_player.play("closed")

func open():
	anim_player.play("open")
