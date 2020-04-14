extends Area2D

export(Array) var dialog_ids

func _ready():
	assert(dialog_ids.size() > 0)

func dialog() -> Array:
	return dialog_ids
