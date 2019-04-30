extends Node

# 各种消息
signal notify_fail(msg)
signal message_vision(msg)
signal say(msg)

# 各种人物状态
signal player_dead(player)
signal enter_room(player)
signal exit_room(player)



#var current_stage
#var player
#
#func connect_signals():
#	connect("notify_fail",current_stage,"_on_notify_fail")
#
#func disconnect_signals():
#	disconnect("notify_fail",current_stage,"_on_notify_fail")
#
#func reset_signals():	