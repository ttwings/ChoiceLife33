extends Node

var turn = 0	

var base_speed = 100
var speed = base_speed
var move_modifier = 0
var base_move_point = speed + move_modifier
var move_point = base_move_point

# 本回合拥有的行动点数
var current_move_point

var action
var next

const UP = Vector2(0,-1)
const DOWN = Vector2(0,1)
const LEFT= Vector2(-1,0)
const RIGHT = Vector2(1,0)

signal turn_process
signal do_action


func turn_process():
	pass


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("down"):
		move(DOWN)
	elif event.is_action_pressed("left"):
		move(LEFT)
	elif event.is_action_pressed("right"):
		move(RIGHT)
	elif event.is_action_pressed("up"):
		move(UP)
#	else:
#		print_debug("error")
	
	
func move(direction:Vector2):
	turn = turn + 1
	var action_name = "turn %d player %s toword %s" % [turn,"move",direction] 
	emit_signal("do_action",action_name)
	var action_cost = int(rand_range(90,110))
	action = action_cost
#	next = move_cost - speed
	move_point = base_move_point - action_cost
	var reduce_point
	if move_point < 0 :
		reduce_point = abs(move_point)
		base_move_point = base_move_point - reduce_point
#		queue_action()
		print("next turn action reduce point",reduce_point)
	else:
		$Sprite.position += direction * 32
		print("move action point %d and direction %s" % [action_cost,direction])
	
var actions = []
var 动作组 = []

func do_action():
	var action
	if actions.size() > 0:
		action = actions.pop_back()
		action.do_action()

func 做动作():
	var 动作
	if 动作组.size() > 0:
		动作 = 动作组.pop_back()
		动作.做动作()

