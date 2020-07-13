extends Node


const PATH_SAVE = "user://savegame.save"
const MAX_FEAR_LEVEL = 3
var data : Dictionary
var fear_level : int = 0 # Vai de 0 a MAX_FEAR_LEVEL
var event_happening : bool = false

func save():
	data = {
		"nivel": 0,
		"info": "test"
	}
	return data

func save_game():
	var save_data = File.new()
	save_data.open(PATH_SAVE, File.WRITE)
	# Quando usamos user://, o arquivo de save fica em:
	# 
	var data = save()
	save_data.store_line(to_json(data))
	save_data.close()

func load_game():
	var saved_game : File = File.new()
	assert(saved_game.file_exists(PATH_SAVE))
	saved_game.open(PATH_SAVE, File.READ)
	while saved_game.get_position() < saved_game.get_len():
		var data = parse_json(saved_game.get_line())
		print("Dados carregados:")
		print(data)
