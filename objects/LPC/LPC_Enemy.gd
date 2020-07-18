extends KinematicBody2D

var hp_max = 100
var hp_current = 100

var velocity = Vector2()
var speed = 100
var nav = null setget set_nav
var path = []
var goal = Vector2() setget set_goal
var pos
var state = "move"
var direction = "left"
# -------- move to goal ----------

func set_goal(_goal:Vector2):
	goal = _goal


func set_nav(new_nav):
	nav = new_nav
	update_path()
	
func update_path():
	pos = position
	path = nav.get_simple_path(pos,goal,false)
	if path.size() == 0:
		set_physics_process(false)	
		
func _physics_process(delta: float) -> void:
	if path.size() > 1 :
		var d = position.distance_to(path[0])
		if d > 2 :
			position = position.linear_interpolate(path[0],(speed * delta)/d)
			is_moving = true
			update_direction(path[0])
#			velocity = position.direction_to(path[0]) * speed
		else :
			is_moving = false
#			print_debug("moving false")
			path.remove(0)
	else:
		is_moving = false
		print_debug("moving false")
		set_physics_process(false)	
#	move_and_slide(velocity)			

onready var animation_player = $AnimationPlayer
var current_animation
var new_animation
var is_moving = false

func on_attack(damage,obj):
	hp_current -= damage

	if hp_current <= 0 :
		hp_current = 0
#		current_state = STATES.DEAD
		animation_player.play("hurt")
#	print_debug(hp_current/hp_max * 100)
	$HP_TextureProgress.value = hp_current * 100/hp_max
	velocity = (self.position - obj.position ).normalized() * damage * 10

	play_animation("ice_018")
#	$Label.text = str(self.position)
	
func play_animation(name):
	$AnimatedSprite.show()
	$AnimatedSprite.frame = 1
	$AnimatedSprite.play(name)
	yield($AnimatedSprite,"animation_finished")
	$AnimatedSprite.hide()	
	
#func _physics_process(delta: float) -> void:
#	velocity = move_and_slide(velocity)
#
#func _process(delta: float) -> void:
#	if path.size() > 0 :
#		update_direction(path[0])

func update_direction(target:Vector2):
	var direction = position.direction_to(target)
#	if angle
	var face_dir = "down" 
	var new_animation = "walk_"
	
	if direction.x > 0.707 :
		face_dir = "right"
	elif direction.x < -0.707 :
		face_dir = "left"
	elif direction.y > 0.707 :
		face_dir = "down"
	elif direction.y < 0.707 :
		face_dir = "up"
		
	new_animation = "walk_" + face_dir 	
	$Label.text = new_animation	
	update_animation(is_moving,new_animation)

func update_animation(is_moving,new_animation):
	if is_moving and current_animation != new_animation :
		animation_player.current_animation = new_animation
		animation_player.play(new_animation)
		current_animation = new_animation
	elif ! is_moving and current_animation != "start" :
		animation_player.play("start")
		animation_player.stop()
		current_animation = 'start'				
