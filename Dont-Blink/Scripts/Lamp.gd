extends Position2D

var glitch : bool = false

func _process(delta):
	if glitch:
		pass

func _on_LampGlitch_body_entered(body):
	glitch = true
	print("glitch de lampada ativado")

func _on_LampGlitch_body_exited(body):
	glitch = false
	print("glitch de lampada desativado")
