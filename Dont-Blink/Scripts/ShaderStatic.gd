extends TextureRect

func _ready():
	visible = false

func _on_Blink_shader_static(on):
	visible = on
