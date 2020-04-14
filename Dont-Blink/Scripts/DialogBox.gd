extends Control

export(String, FILE, "*.json") var dialogue_file_path

onready var rich_text = $Container/HBoxContainer/PanelContainer2/RichTextLabel
onready var tween = $Tween
onready var next_indicator = $Container/HBoxContainer/NextIcon

var dialog : Dictionary
var finished : bool = false
var dialog_index : int = 0
var ids : Array

signal complete

func _ready():
	# Carrega todos os diálogos do jogo do JSON
	dialog = load_from_json()

func _process(delta):
	next_indicator.visible = finished
	if Input.is_action_just_pressed("ui_accept"):
		load_dialog()

func load_dialog():
	if dialog_index < ids.size():
		finished = false
		var active_id : String = ids[dialog_index]
		rich_text.bbcode_text = dialog[active_id]["text"]
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
		# Roda a animação
		tween.start()
	else:
		# Finaliza o diálogo
		rich_text.bbcode_text = ""
		dialog_index = 0
		ids = []
		emit_signal("complete")
		return
	dialog_index += 1

func load_from_json() -> Dictionary:
	"""
	Faz o parse de um arquivo JSON e retorna um dicionário
	"""
	var file  = File.new()
	assert(file.file_exists(dialogue_file_path))
	file.open(dialogue_file_path, file.READ)
	var dialogue = parse_json(file.get_as_text())
	assert(dialogue.size() > 0)
	return dialogue

func _on_Tween_tween_completed(object, key):
	finished = true

func prepare_dialog(ids_to_set : Array):
	ids = ids_to_set
