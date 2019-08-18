extends Control

var player_data

func _ready():
	player_data = gdutils.utils.json.load_json("res://data/user/l/lijia.json")
	print(player_data.dbase)
	$RichTextLabel.text =  str(player_data)
	pass
