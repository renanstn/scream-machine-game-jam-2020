extends KinematicBody2D

const GRAVITY = 20
const UP = Vector2(0, -1)

onready var anim_player = $AnimationPlayer
onready var timer_visible = $TimerVisible

var motion : Vector2

func _ready():
	anim_player.play("idle")
	timer_visible.start()

func _physics_process(delta):
	motion.y += GRAVITY
	motion = move_and_slide(motion, UP)

func set_time_visible(time):
	timer_visible.wait_time = time

func _on_TimerVisible_timeout():
	queue_free()
