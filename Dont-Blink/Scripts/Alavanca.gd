extends Area2D

export(int) var door_to_open

onready var sprite = $Sprite
onready var coll = $CollisionShape2D
onready var sound = $AlavancaSound

func open_door():
	sprite.frame = 1
	sound.play()
	change_fear_level()
	coll.disabled = true

func change_fear_level():
	Global.fear_level += 1
