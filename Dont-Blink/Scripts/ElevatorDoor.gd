extends StaticBody2D

export(int) var level

onready var anim_player = $AnimationPlayer

func _ready():
	if level == 0:
		anim_player.play("open")
	else:
		anim_player.play("closed")

func close_door():
	anim_player.play("closed")
	
func open_door():
	anim_player.play("open")
