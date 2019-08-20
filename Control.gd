extends Control

var player_data
onready var labels = $labels


func _ready():
	player_data = gdutils.utils.json.load_json("res://data/user/l/lijia.json")
	print(player_data)
#	$RichTextLabel.bbcode_text =  dic2bbcode(player_data.dbase)
	dic2bbcode(player_data.dbase)
	pass
#
func dic2bbcode(char_dic:Dictionary):
	for key in char_dic.keys() :
		var path = "PanelAttribute/Label_" + key + "/value"
		if get_node(path) :
			if get_node(path) as Label :
				get_node(path).text = str(char_dic[key])

