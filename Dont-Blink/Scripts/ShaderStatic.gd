extends TextureRect

onready var audio_static = $AudioStatic

func _ready():
	visible = false

func _on_Blink_shader_static(on):
	visible = on
	if on:
		audio_static.play()
	else:
		audio_static.stop()
