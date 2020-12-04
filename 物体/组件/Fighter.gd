extends Node

signal 生命改变(为)
signal 当前生命改变(为)
signal 死了()

# signal hp_changed( to )
# signal current_hp_changed( to )
# signal died()

# These are overridden for RPG.player!
export(float) var 移动速度 = 1.0
export(int) var 生命 = 10 setget _set_生命
var 当前生命 =  -1 setget _set_当前生命
export(bool) var 无敌的 = false

func 获取武器伤害():
	return 3

func 获取攻击点数():
	return 0

func 获取护甲等级():
	return 10

# export(float) var move_speed = 1.0	
# export(int) var hp = 10 setget _set_hp


# var current_hp = -1 setget _set_current_hp

# export(bool) var invincible = false

# func get_weapon_damage():
# 	return 3

# func get_attack_bonus():
# 	return 0


# func get_armor_class():
# 	return 10


func 死亡(被谁):
	if get_parent().智能:
		get_parent().智能.活着 = false	

	if get_parent().pawn:
		get_parent().pawn.queue_free()
	全局游戏.消息面板.消息("%s 被 %s 杀死了" % [get_parent().get_message_name(),被谁])
	emit_signal("死了")

# func die(from_string):
# 	if get_parent().ai:
# 		get_parent().ai.alive = false
	
# 	if get_parent().pawn:
# 		get_parent().pawn.queue_free()
# 	RPG.messageboard.message( "%s was killed by %s" % [get_parent().get_message_name(), from_string] )
# 	emit_signal("died")

func 前进或攻击(方向):
	var 行动了 = true
	var 新单元 = get_parent().单元 + 方向
	var 碰撞物 = 全局游戏.地图.get_collider(新单元)
	if 碰撞物 == 全局游戏.地图:
		行动了 = false
	elif 碰撞物 != null and 碰撞物 != self:
		攻击(碰撞物)
	else:
		get_parent().单元 = 新单元
	if 行动了:

		get_parent().emit_signal("行动了",DATA.DEFAULT_ACTION_TIME)
	
# func step_or_attack( direction ):
# 	# assert(direction in RPG.DIRECTIONS.values()) 
	
# 	var acted = true
	
# 	var new_cell = get_parent().cell + direction
	
# 	# Check for colliders at new cell
# 	var collider = RPG.map.get_collider( new_cell )
# 	if collider == RPG.map: # if the collider is a wall..
# 		acted = false # dont count this as an action
# 	elif collider != null and collider != self: # if collider can be attacked..
# 		attack( collider )

# 	else: # the cell is empty, so step there
# 		get_parent().cell = new_cell
# 	# Emit the acted signal, or not..
# 	if acted:
# 		get_parent().emit_signal("acted",DATA.DEFAULT_ACTION_TIME)
	

# func attack( who ):
# 	var result = RPG.process_attack( get_parent(), who )
# 	if result.hits:
# 		if who.fighter:
# 			who.fighter.take_damage( result.damage, get_parent().get_message_name() )

func 攻击(目标):
	var 结果 = 全局游戏.执行攻击(get_parent(),目标)
	if 结果.击中:
		if 目标.战士:
			目标.战士.受到伤害(结果.伤害,get_parent().get_message_name())			


# func heal_damage( amt, from_string="A mysterious force" ):
# 	pass

func 受到治疗(量,从哪="一股神秘的力量"):
	pass
	
func 受到伤害(量,从哪="一股神秘的力量"):
	if 无敌的:
		全局游戏.消息面板.消息("%s 无法被伤害" % get_parent().get_message_name())
		return
	量 = clamp(量,0,self.当前生命)
	self.当前生命 -= 量
	全局游戏.消息面板.攻击信息(从哪,get_parent().get_message_name(),量)
	if self.当前生命 <= 0:
		死亡(从哪)

# func take_damage( amt, from_string="A mysterious force" ):
# 	if invincible:
# 		RPG.messageboard.message( "%s cannot be harmed" % get_parent().get_message_name() )
# 		return
# 	# Clamp incoming damage. N less than zero, no more than our current HP
# 	amt = clamp( amt, 0, self.current_hp )
# 	# Adjust HP property
# 	self.current_hp -= amt
# 	# Print an attack message
# 	RPG.messageboard.message_attack( from_string, get_parent().get_message_name(), amt )
# 	# Check for death
# 	if self.current_hp <= 0:
# 		die( from_string )


# func setup():
# 	connect( "died", get_parent(), "_on_fighter_died" )
# 	get_parent().fighter = self
# 	self.current_hp = self.hp

func setup():
	connect( "死了", get_parent(), "_on_战士死亡" )
	get_parent().战士 = self
	self.当前生命 = self.生命	

func _set_生命(多少):
	生命 = 多少
	emit_signal("生命改变",生命)
	
func _set_当前生命(多少):
	当前生命 = 多少
	emit_signal("当前生命改变",生命)

# func _set_hp( what ):
# 	hp = what
# 	emit_signal( "hp_changed", hp )

# func _set_current_hp( what ):
# 	current_hp = what
# 	emit_signal( "current_hp_changed", current_hp )
