extends Node

export(String,FILE) var json_file
export(String) var id

var data_base
var data

func setup() -> void:
	var file = File.new()
	file.open(json_file,File.READ)
	data_base = JSON.parse(file.get_as_text()).result
	data = data_base[id]
	file.close()

func _ready() -> void:
	setup()
	print(data[1])
