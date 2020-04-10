extends TextureRect

onready var anim_player = $AnimationPlayer
onready var timer = $Timer

signal time_left(time_left)

func _ready():
	timer.start()
	
func _process(delta):
	emit_signal("time_left", timer.time_left)


func blink():
	anim_player.play("Blink")
	timer.start()

func _on_TestEmitter_test():
	print("Blink!")
	blink()
