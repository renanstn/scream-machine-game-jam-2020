extends Area2D


onready var anim_player = $AnimationPlayer
onready var timer_visible = $TimerVisible

var fear_level : int
var timer_levels = {
	1: 1.5,
	2: 2.0,
	3: 3.0
}

func _ready():
	fear_level = Global.fear_level
	# No level 1 o monstro somente aparece parado
	if fear_level == 1:
		anim_player.play("idle")
	# No level 2 e 3 o monstro já persegue
	elif fear_level == 2 or fear_level == 3:
		anim_player.play("walking")
	
	timer_visible.wait_time = timer_levels[fear_level]
	timer_visible.start()

func set_time_visible(time):
	timer_visible.wait_time = time

func _on_TimerVisible_timeout():
	queue_free()
