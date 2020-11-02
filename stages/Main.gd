extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

signal caption_change(value)

var apple = load("res://clone/food/apple.gd").new()
var player = Char.new()

#var stage_cooking = preload("res://stages/Cooking.tscn")
export (PackedScene) var stage_cooking 
export (PackedScene) var stage_checkout
#var stage_checkout = preload("res://stages/Checkout.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
#	emit_signal("capation_change",[12345678])
	player.dbase = load("res://data/user/l/lijia.gd").new().dbase
	$ObjectRect.get_item_info(apple)
	$ObjectRect.connet_action(apple,player)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Cooking_pressed() -> void:
	get_tree().change_scene_to(stage_cooking)
	pass # Replace with function body.


func _on_Checkout_pressed() -> void:
	get_tree().change_scene_to(stage_checkout)
	pass # Replace with function body.
