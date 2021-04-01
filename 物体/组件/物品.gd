extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var 价格 : int
export var 材质 : String

export(int,0,10000) var 体积 = 0
export(int,0,10000) var 重量 = 0


onready var 持有者 = get_parent()
var 标签 : Label
var 区域 : Area2D
# Called when the node enters the scene tree for the first time.
func _ready():
	if 持有者.has_node("Label"):
		标签 = 持有者.get_node("Label")
		print_debug(标签.text)
	if 持有者.has_node("Area2D"):
		区域 = 持有者.get_node("Area2D")
	if 标签 and 持有者.has_node("物体"):
		标签.text = 持有者.get_node("物体").名称	
		区域.connect("mouse_entered",self,"do_显示标签")
		区域.connect("mouse_exited",self,"do_隐藏标签")
	pass # Replace with function body.

func do_显示标签():
	标签.show()
	
func do_隐藏标签():
	标签.hide()

func do_观察():
	pass
	
