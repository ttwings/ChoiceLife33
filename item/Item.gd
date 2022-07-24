class_name Item

extends Node

export var alias:String

## sprite
export var _icon:NodePath
var icon
## Attack res
export var _melee:NodePath
export var _ranged:NodePath
var melee
var ranged
## Defense
export var defense:NodePath
## Use
export var use:NodePath
export var quaff:NodePath
export var activate:NodePath

func _ready():
	if _icon and get_node(_icon) is Sprite:
		icon = get_node(_icon)
	if _melee:
		print_debug(_melee)
	if _melee and get_node(_melee) is Attack:
		melee = get_node(_melee)
