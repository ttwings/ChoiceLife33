extends Node2D

# 战斗系统
class_name Battle

signal win
signal loose

var player
var enemy

var playerStateUI
var enemyStateUI

var playerPropertyPanel
var enemyPropertyPanel

var skillUI
onready var itemUI = $ui/ItemUI
var tscn_JumpNumber = preload("jumps/JumpNumber.tscn")
var tscn_JumpName = preload("jumps/JumpName.tscn")

var jumpNumberPlace

func _ready():
	jumpNumberPlace = $jumpNumberPlace
	pass

func start(_player,_enemy):
	player.set(_player)
	enemy.set(_enemy)
	# 注册信号侦听
	player.connect("attack",self,"onAttack")
	pass
	
func onAttack(fromChara,toChara):
	var dmgObj = DmgObjFactory.createAttackDmg(fromChara,toChara,fromChara.atk)
	BattleProcess.damageProcess(dmgObj)
	
func onJumpNumber(dmgObj,position):
	var jumpNumber = tscn_JumpNumber.instance()
	jumpNumberPlace.add_child(jumpNumber)
	jumpNumber.start(dmgObj,position)

func onJumpName(name,position):
	var jumpName = tscn_JumpName.instance()
	jumpNumberPlace.add_child(jumpName)
	jumpName.start(name,position)
	
func onJumpMiss(position):
	var jumpName = tscn_JumpName.instance()
	jumpNumberPlace.add_child(jumpName)
	jumpName.start("闪避",position)	
	
func onJumpPerry(position):
	var jumpName = tscn_JumpName.instance()
	jumpNumberPlace.add_child(jumpName)
	jumpName.start("招架",position)		
	
func onDie(character):
	player.set_process(false)
	enemy.set_process(false)
	# 去除所有触发器
	TriggerSystem.triggerList = []
	# 等待1.5秒
	yield(get_tree().create_timer(1.5),"time_out")
	if character == enemy :
		win()
	else:
		lose()
	
func win():
	emit_signal("win")
	
func lose():
	emit_signal("loose")

		