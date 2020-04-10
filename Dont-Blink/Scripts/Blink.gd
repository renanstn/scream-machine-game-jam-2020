extends TextureRect


onready var anim_player = $AnimationPlayer

func _on_TestEmitter_test():
	print("Blink!")
	blink()

func blink():
	anim_player.play("Blink")
