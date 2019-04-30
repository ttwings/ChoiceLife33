extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var apple = load("res://clone/food/apple.gd").new()
var player = Char.new()
# Called when the node enters the scene tree for the first time.
func _ready():

	player.dbase = load("res://data/user/l/lijia.gd").new().dbase
	$ObjectRect.get_item_info(apple)
	$ObjectRect.connet_action(apple,player)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass