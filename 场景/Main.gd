extends Control

export(PackedScene) var game_cooking
export(PackedScene) var game_checkout

signal caption_change(value)

#var apple = load("res://clone/food/apple.gd").new()
#var player = Char.new()
var stage_cooking = preload("res://场景/game_cooking/Cooking.tscn")
var stage_checkout = preload("res://场景/game_checkout/Checkout.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
#	emit_signal("capation_change",[12345678])
#	get_tree().add_child(stage_checkout)
#	get_tree().add_child(stage_cooking)
#	player.dbase = load("res://data/user/l/lijia.gd").new().dbase
#	$ObjectRect.get_item_info(apple)
#	$ObjectRect.connet_action(apple,player)
	pass # Replace with function body.

func _on_Cooking_pressed() -> void:
	get_tree().change_scene_to(stage_cooking)
	pass # Replace with function body.


func _on_Checkout_pressed() -> void:
	get_tree().change_scene_to(stage_checkout)
	pass # Replace with function body.
