extends TextureRect

onready var anim_player = $AnimationPlayer
onready var audio_player = $AudioStreamPlayer
onready var timer = $Timer

signal time_left(time_left)
signal max_value(value)

func _ready():
	timer.start()
	emit_signal("max_value", timer.wait_time)

func _process(delta):
	emit_signal("time_left", timer.time_left)
	if Input.is_action_just_pressed("blink") and not anim_player.is_playing():
		blink()

func blink():
	print("blink!")
	audio_player.play()
	anim_player.play("Blink")
	timer.start()

func _on_TestEmitter_test():
	blink()
