extends Node

onready var 持有者 = get_parent()

# 混乱
func do_随机移动():
	var 上 = randi()%2
	var 下 = randi()%2
	var 左 = randi()%2
	var 右 = randi()%2
	var 方向 = Vector2(右-左,下-上)
	持有者.前进(方向)

# # Confused
# func random_step():
# 	var UP = randi()%2
# 	var DOWN = randi()%2
# 	var LEFT = randi()%2
# 	var RIGHT = randi()%2
# 	var dir = Vector2( RIGHT-LEFT, DOWN-UP )
# 	owner.step(dir)


# GRAB action
# func Grab():
# 	var items = []
# 	for ob in GameData.map.get_objects_in_cell(owner.get_map_pos()):
# 		if ob.item:
# 			items.append(ob)
# 	if not items.empty():
# 		var result = items[0].item.pickup()
# 		if result == OK:
# 			owner.emit_signal('object_acted')

func do_捡起(格子 = 持有者.格子):
	var 物体 = 持有者.地图.get_格子中的物体(持有者.格子)
	if not 物体.empty():
		for 某物体 in 物体:
			if "物品" in 物体.组件:
				物体.组件.物品.捡起()
				全局游戏.消息面板.消息("你捡起 %s " % 物体.get_发送信息对象名称)
				持有者.emit_signal("完成动作",全局数据.默认行动时间)
				break
# DROP action
func do_丢下():
	if 全局游戏.in_使用 == true:
		全局游戏.广播("点击地图确定,邮件取消")
		return
	全局游戏.背包.call_丢弃菜单()
	var 物品 = yield(全局游戏.背包菜单, '物品已选择')
	if 物品.empty():
		全局游戏.广播("动作取消")
	else:
		for 某物品 in 物品:
			某物品.组件.物品.do_丢下()
			持有者.emit_signal('完成动作')


# DROP action
# func Drop():
# 	if GameData.in_use == true:
# 		GameData.broadcast("Click the map to confirm, RMB to cancel")
# 		return
# 	GameData.inventory.call_drop_menu()
# 	var items = yield(GameData.inventory_menu, 'items_selected')
# 	if items.empty():
# 		GameData.broadcast("action cancelled")
# 	else:
# 		for obj in items:
# 			obj.item.drop()
# 			owner.emit_signal('object_acted')

#THROW action
# func Throw():
# 	if GameData.in_use == true:
# 		GameData.broadcast("Click the map to confirm, RMB to cancel")
# 		return
# 	GameData.inventory.call_throw_menu()
# 	var obj = yield(GameData.inventory_menu, 'items_selected')
# 	if obj.empty():
# 		GameData.broadcast("action cancelled")
# 	else:
# 		obj = obj[0]
# 		obj.item.throw(1)

#THROW action
func do_扔出():
	if 全局游戏.in_使用 == true:
		全局游戏.广播("点击地图确定,右键取消")
		return
	全局游戏.背包.call_扔出菜单()
	var 物品 = yield(全局游戏.背包菜单, '物品已选择')
	if 物品.empty():
		全局游戏.广播("动作取消")
	else:
		物品 = 物品[0]
		物品.组件.物品.do_扔出(1)		

# WAIT action
# func Wait():
# 	owner.emit_signal('object_acted')

func do_等待():
	持有者.emit_signal("完成动作")

func do_观察():
	pass

# func _ready():
# 	GameData.player = owner
# 	owner.connect("object_moved", GameData.map.get_node('Fogmap'), '_on_player_pos_changed')
# 	owner.connect("object_acted", GameData.map, "_on_player_acted")
# 	set_process_input(true)

func _ready():
	全局游戏.玩家 = 持有者
	持有者.connect("物体完成移动",全局游戏.地图.get_node("迷雾地图"),"_on_玩家格子改变")
	持有者.connect("物体完成动作",全局游戏.地图,"_on_玩家完成动作")	
	set_process_input(true)


func _input(事件):
	var 向北 = 事件.is_action_pressed('向北')
	var 向东北 = 事件.is_action_pressed('向东北')
	var 向东 = 事件.is_action_pressed('向东')
	var 向东南 = 事件.is_action_pressed('向东南')
	var 向南 = 事件.is_action_pressed('向南')
	var 向西南 = 事件.is_action_pressed('向西南')
	var 向西 = 事件.is_action_pressed('向西')
	var 向西北 = 事件.is_action_pressed('向西北')
	var 等待 = 事件.is_action_pressed('等待')
	
	var 捡起 = 事件.is_action_pressed('捡起')
	var 丢下 = 事件.is_action_pressed('丢下')
	var 扔出 = 事件.is_action_pressed('扔出')
	# Status effects
	if 持有者.组件.战斗.has_状态效果('混乱'):
		if 向北 || 向东北 || 向东 || 向东南 || 向南 || 向西南 || 向西 || 向西北 || 等待:
			do_随机移动()
			return
	if 持有者.组件.战斗.has_状态效果('瘫痪') || 持有者.组件.战斗.has_状态效果('晕眩'):
		if 向北 || 向东北 || 向东 || 向东南 || 向南 || 向西南 || 向西 || 向西北:
			do_等待()
			return
	
	if 向北:
		持有者.do_前进或攻击(Vector2(0,-1))
	if 向东北:
		持有者.do_前进或攻击(Vector2(1,-1))
	if 向东:
		持有者.do_前进或攻击(Vector2(1,0))
	if 向东南:
		持有者.do_前进或攻击(Vector2(1,1))
	if 向南:
		持有者.do_前进或攻击(Vector2(0,1))
	if 向西南:
		持有者.do_前进或攻击(Vector2(-1,1))
	if 向西:
		持有者.do_前进或攻击(Vector2(-1,0))
	if 向西北:
		持有者.do_前进或攻击(Vector2(-1,-1))
	
	if 等待:
		do_等待()
	if 捡起:
		do_捡起()
	if 丢下:
		do_丢下()
	if 扔出:
		do_扔出()		
