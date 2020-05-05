extends Position2D

onready var light = $FeixeDeLux
onready var timer = $Timer
onready var sound = $LightSound
onready var animation = $AnimationPlayer

func _ready():
	animation.play("balance")
	randomize()
	# var random_speed = rand_range(0, 1)
	# animation.playback_speed = random_speed
	var random_start = rand_range(0, 4)
	animation.seek(random_start)

func _on_LampGlitch_body_entered(body):
	if body.name == "Player":
		timer.start()

func _on_LampGlitch_body_exited(body):
	if body.name == "Player":
		light.enabled = true
		timer.stop()

func _on_Timer_timeout():
	"""
	Efeito de fazer a luz dar pequenas piscadas quando o player
	está embaixo dela, mas mantendo-a mais acesa do que apagada.
	"""
	var next_wait_time : float
	if light.enabled:
		next_wait_time = rand_range(1, 3)
	else:
		next_wait_time = 0.05
		sound.play()
	light.enabled = !light.enabled
	timer.wait_time = next_wait_time
