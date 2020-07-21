extends TextureRect

func _on_Blink_time_left(time_left):
	if not Global.event_happening:
		# Tempo em que a visão começa a embaçar
		if time_left < 5.0 and modulate.a < 1.0:
			show()
			modulate.a += 0.01

func _on_Blink_blink():
	hide()
	modulate.a = 0.0
