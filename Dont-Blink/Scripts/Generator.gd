extends Area2D

onready var anim_player = $AnimationPlayer
onready var sound = $AudioStreamPlayer2D

func _ready():
	anim_player.play("working")
	sound.play()
