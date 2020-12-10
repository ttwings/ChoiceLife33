extends Node

class_name 战斗

signal 最大生命改变(为)
signal 当前生命改变(为)

signal 受到伤害(量,从哪)
signal 死亡(被谁)

export(int) var 历练值 = 1

export(float) var 移动速度 = 1.0

export(int) var 最大生命 = 10 setget _set_最大生命
export(int) var 当前生命 =  -1 setget _set_当前生命
# export(int) var 最大灵气 = 10 setget _set_最大灵气
# export(int) var 当前灵气 =  -1 setget _set_当前灵气
# export(int) var 最大神念 = 10 setget _set_最大神念
# export(int) var 当前神念 =  -1 setget _set_当前神念

export(bool) var 无敌的 = false

export(int,"练气期","筑基期","金丹期","元婴期","化神器") var 境界 = 1
export(int,0,9) var 层次 = 0

export(int,1,255) var 肉体 = 1
export(int,1,255) var 灵力 = 1
export(int,1,255) var 神识 = 1

export(int) var 最小基础伤害 = 0
export(int) var 最大基础伤害 = 2

onready var 持有者 = get_parent()
var 武装

func get_要存储数据():
	var 数据 = {
		"生命" : self.生命,
	}
	if 武装 :
		if 武装.has_method("get_要存储数据"):
			数据.武装 = 武装.get_要存储数据()
	return 数据

func is_满生命():
	return self.当前生命 >= self.最大生命

func get_肉体():
	#TODO
	var total = self.肉体
	return total

func get_灵力():
	#TODO
	var total = self.灵力
	return total

func get_神识():
	#TODO
	var total = self.神识
	return total		


func do_杀死(被谁):
	emit_signal("死亡",被谁)
	if 持有者:
		if "玩家" in 持有者.组件:
			持有者.组件.玩家.do_消灭(被谁)
	else:
		全局游戏.消息面板.消息("%s 死了" % 持有者.get_发送信息对象名称())
		持有者.do_消灭()

func do_前进或攻击(方向):
	var 行动了 = true
	var 新格子 = get_parent().格子 + 方向
	var 碰撞物 = 全局游戏.地图.get_collider(新格子)
	if 碰撞物 == 全局游戏.地图:
		行动了 = false
	elif 碰撞物 != null and 碰撞物 != self:
		do_攻击(碰撞物)
	else:
		get_parent().格子 = 新格子
	if 行动了:

		get_parent().emit_signal("行动了",全局数据.默认行动时间)

func do_攻击(目标):
	var 结果 = 全局游戏.执行攻击(get_parent(),目标)
	if 结果.击中:
		if 目标.战士:
			目标.战士.受到伤害(结果.伤害,get_parent().get_发送信息对象名称())			

func get_治疗(量,从哪="一股神秘的力量"):
	量 = min(量,self.最大生命 - self.当前生命)
	self.当前生命 += 量
	全局游戏.消息面板.治疗信息(持有者,量)
	pass
	
func get_伤害(量,从哪=null):
	if 无敌的:
		全局游戏.消息面板.消息("%s 无法被伤害" % get_parent().get_发送信息对象名称())
		return
	量 = clamp(量,0,self.当前生命)
	self.当前生命 -= 量
	emit_signal("受到伤害",量,从哪)
	var 攻击者名 = "一股神秘的力量"
	if 从哪 != null :
		攻击者名 = 从哪.get_发送信息对象名称()
	var 受攻击者 = 持有者.get_发送信息对象名称()
	全局游戏.消息面板.攻击信息(攻击者名,受攻击者,量)

	if self.当前生命 <= 0  and !无敌的:
		do_杀死(从哪)

func setup():
	connect( "死了", get_parent(), "_on_战士死亡" )
	get_parent().战士 = self
	self.当前生命 = self.生命	

func _set_最大生命(生命):
	最大生命 = 生命
	emit_signal("最大生命改变",生命)
	
func _set_当前生命(生命):
	当前生命 = 生命
	emit_signal("当前生命改变",生命)
