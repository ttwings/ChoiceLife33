extends Node

class_name 物体

signal 地图格子改变(从,到)

signal 完成动作(延迟)
signal 完成移动
signal 开始行动(延迟)

signal 消灭(对象)

onready var 持有者 = get_parent()

export(String) var 名称 = "物体"
export(String,MULTILINE) var 描述 = "这是个物体"
#export(Texture) var 精灵图路径 = preload("res://icon.png") setget _set_精灵图路径


export(bool) var 阻挡移动 = false setget _set_阻挡移动
export(bool) var 阻挡视线 = false setget _set_阻挡视线

var 发现 = false

var 格子 = Vector2() setget _set_格子,_get_格子
var 坐标
var 组件 = {}
var 状态效果 = {}

var SID = -1
var 数据地址
var pawn = null
var 在库存中 = false

func get_要存储数据():
	var 数据 = {
		"id":self.SID,
		"地址":self.数据地址,
		"格子":{
			"x":self.格子.x,
			"y":self.格子.y
		},
		"发现":self.发现,
		"组件":{}
	}
	for 某组件 in self.组件:
		if self.组件[某组件].has_method("get_要存储数据"):
			var 组件数据 = self.组件[某组件].get_要存储数据
			数据.组件[某组件] = 组件数据

func get_发送信息对象名称():
	if "player" in self.组件:
		return "你"
	else:
		return self.名称

func is_被诅咒():
	return "装备" in self.组件 and self.组件.装备.诅咒

func is_被玩家装备():
	return self in get_node("/root/全局游戏").玩家.组件.战斗.武装.部位
	
func get_伤害(量,从=null):
	if "战士" in 组件:
		self.组件.战斗.受到伤害(量,从)
	
func do_消灭():
	if self.阻挡移动 or self.阻挡视线:
		emit_signal("地图格子改变",self.格子,null)
	queue_free()


# Component refs
# var 战士
# var 物品
# var 装备
# var 智能

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

func _游戏_执行(delta=5.0):
	for 某状态 in self.状态效果.values():
		某状态._游戏_执行(delta)
	if "智能" in self.组件 :
		self.组件.智能.执行(delta)

func _ready():
	connect("准备行动",self,"_准备行动")
	add_to_group("物体")
	if self.阻挡移动:
		add_to_group("阻挡行动物体")
	if self.阻挡视线:
		add_to_group("阻挡视线物体")

#func _enter_tree():
#	$Sprite.texture = 精灵图路径		
	
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


func _get_格子():
	if 持有者 is TileMap:
		return 持有者.world_to_map(坐标)
#	else:
#		return 持有者.持有者._get_格子()

func _set_格子( 新格子 ):
	var 旧格子 = self.格子
	if 持有者 is TileMap:
		self.position = 持有者.map_to_world(新格子)
	else:
		self.position = 持有者.持有者.map_to_world(新格子)
	emit_signal( "地图格子改变",旧格子,新格子)

#func _set_精灵图路径(新路径):
#	精灵图路径 = 新路径
#	if is_inside_tree():
#		$Sprite.texture = 精灵图路径
		
func _准备行动(delta):
	_游戏_执行(delta)		

	
# func _on_战士死亡():
# 	emit_signal("消灭",self)
			
