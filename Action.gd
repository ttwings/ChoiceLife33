extends Node

class_name Action

export var act_name:= "action"
export var action_point := 100
export var action_message := ""
export var direction = Vector2(0,0)

var Owner

func setup():
	Owner = get_parent()
	Owner.add_action(self)
	
func do():
	pass
