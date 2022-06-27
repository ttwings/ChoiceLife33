extends Node

onready var 持有者 = get_parent()
onready var owner = get_parent()

var is_dead = false
func do_get_item_current_cell(cell):
	var item = get_item_current_cell(cell)
	if item

var is_死亡 = false

func do_捡起当前格物品(格子 = 持有者.格子):
	var 物体 = 持有者.地图.get_格子中的物体(持有者.格子)
	if not 物体.empty():
		for 某物体 in 物体:
			if "物品" in 物体.组件:
				物体.组件.物品.捡起()
				全局游戏.
				全局游戏.消息面板.消息("你捡起了 %s " % 物体.get_发送信息对象名称)
				持有者.emit_signal("完成动作",全局数据.默认行动时间)
				break

func do_杀死(被谁):
	is_死亡 = true
	全局游戏.消息面板.消息_玩家死亡()

func killed_by(who):
	if not is_死亡:
		do_杀死(who)
	
func do_进入地图(地图):
	持有者.connect("地图格子改变",地图,"_on_玩家地图格子改变")
	持有者.connect("完成动作",地图,"_on_玩家完成动作")

func _ready() -> void:
	if 持有者:
		持有者.组件["玩家"] = self
		持有者.get_node("Camera").make_current()
		持有者.发现 = true
		全局游戏.玩家 = self
