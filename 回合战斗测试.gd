extends Control

var v_测试
var nihao 
var 回合测试

# 将回合融入到基本行动中,按照行动进行判断
# 深入使用现有结构,

onready var speed_label = $speed
onready var action_label = $action
onready var next_label = $next

onready var message_board = $MessageBoard

onready var player = $player

func _ready() -> void:
	pass
	
func _process(delta: float) -> void:
	pass
	
	
func next_turn():
	pass
	
func process_turn():
	pass
	
func player_turn():
	
	pass
	
func enemy_turn():
	pass
	
func npc_turn():
	pass	


func _on_player_do_action(message) -> void:
	speed_label.get_node("value").text = str($player.speed)
	action_label.get_node("value").text = str($player.action)
	next_label.get_node("value").text = str($player.next)
	message_board.text += message + "\n"	
	pass # Replace with function body.
