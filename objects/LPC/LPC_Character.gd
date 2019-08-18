tool
extends Node2D

onready var player = $Sprite
onready var animation_player = $AnimationPlayer

var current_animation = "start"
var speed = 200
var velocity = Vector2(0,0)
var is_moving = false
var new_animation

func _process(delta: float) -> void:
	velocity = Vector2(0,0)
	is_moving = false
	new_animation = current_animation
	# update
	update_animation(is_moving,new_animation)
	
func update_animation(is_moving,new_animation):
	if is_moving and current_animation != new_animation :
		animation_player.current_animation = new_animation
		animation_player.play(new_animation)
		current_animation = new_animation
	elif ! is_moving and current_animation != "start" :
		animation_player.stop()
		current_animation = 'start'			
