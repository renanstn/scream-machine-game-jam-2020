extends Node
class_name DialogueAction

export(String, FILE, "*.json") var dialogue_file_path

func load_dialogue():
	"""
	Faz o parse de um arquivo JSON e retorna um dicionário
	"""
	var file  = File.new()
	assert(file.file_exists(dialogue_file_path))
	
	file.open(dialogue_file_path, file.READ)
	var dialogue = parse_json(file.get_as_text())
	assert(dialogue.size() > 0)
	return dialogue
