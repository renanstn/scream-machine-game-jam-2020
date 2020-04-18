extends KinematicBody2D

onready var timer = $Timer
onready var light = $Light2D
onready var sound = $ElevatorSound
onready var animation = $AnimationPlayer

func _physics_process(delta):
	if Input.is_action_pressed("test"):
		var vetor = Vector2(0, -18)
		move_and_slide(vetor)
		animation.play("working")
		if not sound.playing:
			sound.play()
	else:
		animation.play("stop")

func _on_Timer_timeout():
	"""
	Efeito de fazer a luz dar pequenas piscadas
	"""
	var next_wait_time : float
	if light.enabled:
		next_wait_time = rand_range(1, 3)
	else:
		next_wait_time = rand_range(0.05, 1.0)
	light.enabled = !light.enabled
	timer.wait_time = next_wait_time
