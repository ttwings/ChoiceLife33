extends Node2D

onready var player = $Character
onready var enemy = $EnemyBase



func _on_turn_process():
	player_turn()
	enemy_turn()
	
func player_turn():
	var left_point = player.move_point - player.action.act_point
	if left_point >= 0:
		player.do_action()
#		player_turn()
	else:
		player.preper_action(left_point)
		
func enemy_turn():
	print_debug("enemy turn")
	pass		


func _on_Character_do_action() -> void:
	player_turn()
	pass # Replace with function body.
