extends Node

# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"

# Called when the node enters the scene tree for the first time.
var table_pos_dic = {}
func _ready() -> void:
	table_pos_dic.cooker = $Position10
	print(var2str(table_pos_dic.cooker))
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
