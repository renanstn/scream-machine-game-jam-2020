extends Area2D

onready var anim_player = $AnimationPlayer
onready var sound = $AudioStreamPlayer2D

export(int) var id

func _ready():
	pass

func turn_on(id_to_turn_on:int):
	if id == id_to_turn_on:
		anim_player.play("working")
		sound.play()
