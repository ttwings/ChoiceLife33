extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const MAX_TURN = 1000.00
var player_start = 0
var enemy_start = 1000
var player_now = player_start
var enemy_now = enemy_start

onready var player_rect = $player_rect
onready var enemy_rect = $enemy_rect

onready var px = player_rect.rect_position.x
onready var px_max = px + MAX_TURN
# Called when the node enters the scene tree for the first time.
func _ready():
	add_rect()
	pass # Replace with function body.

func _process(delta):
	if player_now > MAX_TURN :
		player_now = player_start
	player_now = player_now + 4
	player_rect.rect_position.x = px + player_now
	$player_rect/Label.text = str(player_now)
#	player_rect.rect_position.x = player_rect.rect_position.x + rand_range(0.2,3.0)
#	if player_rect.rect_position.x > px_max :
#		player_rect.rect_position.x = px
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func add_rect():
	var rect = $player_rect.duplicate()
	rect.rect_position.x = 100
	add_child(rect)


func actor_runing(actor):
	if actor.turn_now > MAX_TURN :
		actor.turn_now = actor.turn_start
	actor.turn_now = actor.turn_now + 4
	player_rect.rect_position.x = px + player_now
	$player_rect/Label.text = str(player_now)
