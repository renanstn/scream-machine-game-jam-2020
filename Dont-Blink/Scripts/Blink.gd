extends TextureRect

onready var anim_player = $AnimationPlayer
onready var blink_sound = $AudioStreamPlayer
onready var timer = $TimerBlink
onready var timer_glitch = $TimerGlitch
onready var timer_scare = $TimerScareImg
onready var scare_sprite = $ScareSprite

enum EVENT {
	no_event,
	scare_glitches,
	scare_image,
	test
}

var event = EVENT.no_event
var event_chance : float = 2 # Valor em porcentagem
var shader_static : bool = false
var shader_active : bool = false

signal time_left(time_left)
signal max_value(value)
signal shader_static(on)
signal blink
signal spawn_monster
signal spawn_monster_walking
signal spawn_monster_running

func _ready():
	yield(get_tree(), "idle_frame")
	timer.start()
	emit_signal("max_value", timer.wait_time)

func _process(delta):
	match Global.fear_level:
		0:
			event = EVENT.no_event
		1:
			event = EVENT.scare_glitches
		2:
			event = EVENT.scare_image

	emit_signal("time_left", timer.time_left)
	if Input.is_action_just_pressed("blink") and not anim_player.is_playing():
		blink()

func blink():
	# Limpa os efeitos caso algum esteja ativo
	if shader_active:
		turn_off_shaders()
	else:
		var chance_evento = rand_range(0, 10)
		if chance_evento < event_chance:
			play_events()
	blink_sound.play()
	anim_player.play("Blink")
	emit_signal("blink")
	timer.start()

func pause_timer():
	timer.paused = true
	
func unpause_timer():
	timer.paused = false

func _on_TimerScareImg_timeout():
	scare_sprite.hide()

func play_events():
	"""
	Aplica o evento ao piscar
	"""
	if event == EVENT.scare_glitches:
		Global.event_happening = true
		shader_active = true
		shader_static = true
		timer_glitch.start()
		emit_signal("shader_static", shader_static)
		emit_signal("spawn_monster")
		
	if event == EVENT.scare_image:
		scare_sprite.show()
		timer_scare.start()
		Global.event_happening = true
		shader_active = true
		shader_static = true
		timer_glitch.start()
		emit_signal("shader_static", shader_static)
		emit_signal("spawn_monster_walking")
		
	if event == EVENT.test:
		emit_signal("spawn_monster_running")

func turn_off_shaders():
	"""
	Verifica qual shader está ativo, e o desliga
	"""
	if shader_static:
		shader_static = false
		emit_signal("shader_static", shader_static)
	shader_active = false
	Global.event_happening = false

func _on_TimerGlitch_timeout():
	turn_off_shaders()
