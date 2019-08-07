extends KinematicBody2D

onready var player = $Sprite
onready var animation_player = $AnimationPlayer
onready var camera = $Camera2D

var current_animation = "start"
var speed = 200
var velocity = Vector2(0,0)
var is_moving = false
var new_animation

func _ready():
	camera.position = player.position

func get_input():
	velocity = Vector2(0,0)
	is_moving = false
	new_animation = current_animation
	if Input.is_action_pressed("left"):
		velocity.x += -1
		new_animation = "walk_left"
		is_moving = true
	if Input.is_action_pressed("right"):
		velocity.x += 1
		new_animation = "walk_right"
		is_moving = true
	if Input.is_action_pressed("up"):
		velocity.y += -1
		new_animation = "walk_up"
		is_moving = true		
	if Input.is_action_pressed("down"):
		velocity.y += 1
		new_animation = "walk_down"
		is_moving = true
	# velocity
	if velocity.length() > 0 :
		velocity = velocity.normalized() * speed
	# update
	update_animation(is_moving,new_animation)

func _physics_process(delta: float) -> void:
	get_input()
	velocity = move_and_slide(velocity)
#		player.position += velocity.normalized() * speed * delta
	update_camera_position()

	
func update_animation(is_moving,new_animation):
	if is_moving and current_animation != new_animation :
		animation_player.current_animation = new_animation
		animation_player.play(new_animation)
		current_animation = new_animation
	elif ! is_moving and current_animation != "start" :
		animation_player.stop()
		current_animation = 'start'			
		
		
func update_camera_position():
	camera.position = player.position		