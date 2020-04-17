extends TextureRect

onready var anim_player = $AnimationPlayer
onready var blink_sound = $AudioStreamPlayer
onready var timer = $TimerBlink
onready var timer_scare = $TimerScareImg
onready var scare_sprite = $ScareSprite

enum EVENT {
	no_event,
	scare_image,
	scare_glitches
}

var event
var shader_static : bool = false
var shader_active : bool = false

signal time_left(time_left)
signal max_value(value)
signal shader_static(on)

func _ready():
	yield(get_tree(), "idle_frame")
	match Global.fear_level:
		0:
			event = EVENT.no_event
		1:
			event = EVENT.scare_image
	timer.start()
	emit_signal("max_value", timer.wait_time)

func _process(delta):
	emit_signal("time_left", timer.time_left)
	if Input.is_action_just_pressed("blink") and not anim_player.is_playing():
		blink()

func blink():
	if shader_active:
		turn_off_shaders()
	else:
		play_events()
	blink_sound.play()
	anim_player.play("Blink")
	timer.start()

func pause_timer():
	timer.paused = true
	
func unpause_timer():
	timer.paused = false

func _on_TimerScareImg_timeout():
	scare_sprite.hide()

func play_events():
	if event == EVENT.scare_image:
		shader_active = true
		shader_static = true
		scare_sprite.show()
		timer_scare.start()
		emit_signal("shader_static", shader_static)

func turn_off_shaders():
	if shader_static:
		shader_static = false
		emit_signal("shader_static", shader_static)
	shader_active = false
