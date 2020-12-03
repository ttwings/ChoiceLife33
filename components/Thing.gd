extends Node

class_name 物体

signal 单元改变(从,到)

signal 准备行动(延迟)
signal 完成行动(动作)

signal 消灭(对象)

export(String) var 物体名称 = "Thing"
export(String) var 描述 = "It's a Thing"
export(Texture) var 默认纹理

export(bool) var 阻挡移动 = false setget _set_阻挡移动
export(bool) var 阻挡视线 = false setget _set_阻挡视线
export(bool) var stay_visibal = false

var 发现 = false


var 单元 = Vector2() setget _set_单元

# func _set_cell():
# 	pass

var SID = -1
var 数据库路径

var pawn = null

var 在库存中 = false

# Component refs
var 战士
var 物品
var 装备
var 智能

func setup():
	connect("准备行动", self, "_游戏_执行")
	add_to_group("物体")
	if 阻挡移动:
		add_to_group("阻挡行动物体")
	if 阻挡视线:
		add_to_group("阻挡视线物体")
	
	for 节点 in get_children():
		if 节点.has_method("安装"):
			节点.安装()

func _游戏_执行(delta):
	if 智能 :
		智能.执行(delta)
	
func _set_阻挡移动(谁):
	阻挡移动 = 谁
	if 阻挡移动:
		if !is_in_group("阻挡行动物体"):
			add_to_group("阻挡行动物体")
	else:
		if is_in_group("阻挡行动物体"):
				remove_from_group("阻挡行动物体")

func _set_阻挡视线( 什么 ):
	阻挡视线 = 什么
	if 阻挡视线:
		if !is_in_group("阻挡视线物体"):
			add_to_group("阻挡视线物体")
	else:
		if is_in_group("阻挡视线物体"):
			remove_from_group("阻挡视线物体")

func _set_单元( 什么 ):
	emit_signal( "单元改变",单元,什么)
	单元 = 什么
	
func _on_战士死亡():
	emit_signal("消灭",self)
			
