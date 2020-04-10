extends Node

signal test

func _process(delta):
	if Input.is_action_just_pressed("test"):
		emit_signal("test")
