extends Node2D


onready var enemy = $trees/LPC_Enemy

func _ready():
#	enemy.instance()
#	$trees.add_child(enemy)
#	enemy.pos = $start.position
	enemy.set_position($start.position)
	enemy.set_goal($end.position)
	enemy.set_nav($navgaition)
	pass

#func _process(delta: float) -> void:
#	enemy._process(delta)