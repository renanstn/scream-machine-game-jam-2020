extends Control

onready var progress_blink = $ProgressBar

func _on_Blink_time_left(time_left):
	progress_blink.value = time_left
