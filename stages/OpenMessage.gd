extends Control

# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"

# Called when the node enters the scene tree for the first time.
var stage_main = preload("res://stages/Main.tscn")
func _ready() -> void:
	
	pass # Replace with function body.



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass


func _on_select_tiny_pressed() -> void:
	get_tree().change_scene_to(stage_main)
	pass # Replace with function body.


func _on_select_huge_pressed() -> void:
	get_tree().change_scene_to(stage_main)
	pass # Replace with function body.
