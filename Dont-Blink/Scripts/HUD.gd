extends Control

onready var progress_blink = $ProgressBar

func _ready():
	# Resolvemos tirar a HUD para uma interface mais limpa
#	show()
	pass

func _on_Blink_max_value(value):
	progress_blink.max_value = value

func _on_Blink_time_left(time_left):
	progress_blink.value = time_left

func _on_Player_hide_hud():
	hide()

func _on_Player_show_hud():
#	show()
	pass
