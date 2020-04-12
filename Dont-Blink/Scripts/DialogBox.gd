extends Control

onready var rich_text = $PanelContainer/HBoxContainer/RichTextLabel
onready var tween = $Tween
onready var next_indicator = $PanelContainer/HBoxContainer/Sprite
onready var dialog_action = $DialogueAction

signal complete

var dialog_index = 0
var finished = false
var dialog : Array

func _ready():
	dialog = dialog_action.load_dialogue()
	load_dialog()

func _process(delta):
	next_indicator.visible = finished
	if Input.is_action_just_pressed("ui_accept"):
		load_dialog()

func load_dialog():
	if dialog_index < dialog.size():
		finished = false
		rich_text.bbcode_text = dialog[dialog_index]["text"]
		rich_text.percent_visible = 0
		tween.interpolate_property(
			rich_text, # Quem vai ser animado
			"percent_visible", # A propriedade que será animada
			0, # Valor inicial
			1, # Valor final
			1, # Valor de cada 'passo'
			Tween.TRANS_LINEAR, # Tipo de animação
			Tween.EASE_IN_OUT # Não sei
		)
		tween.start()

	else:
		emit_signal("complete")
	dialog_index += 1

func _on_Tween_tween_completed(object, key):
	finished = true
