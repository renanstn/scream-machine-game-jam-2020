extends StaticBody2D

export(int) var id
onready var anim_player = $AnimationPlayer

func _ready():
#	anim_player.play("closed")
	pass

func open():
	anim_player.play("open")


func _on_TestEmitter_test():
	open()
