extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var 坐标 = Vector2(1,1)


# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.


func _process(delta):
	self.position = self.position + 坐标
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
