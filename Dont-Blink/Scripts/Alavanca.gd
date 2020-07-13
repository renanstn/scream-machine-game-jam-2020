extends Area2D

export(int) var door_to_open
export(bool) var change_fear_level

onready var sprite = $Sprite
onready var coll = $CollisionShape2D
onready var sound = $AlavancaSound

func open_door():
	sprite.frame = 1
	sound.play()
	coll.disabled = true
	if change_fear_level:
		change_fear_level()

func change_fear_level():
	if Global.fear_level < Global.MAX_FEAR_LEVEL:
		Global.fear_level += 1
