extends KinematicBody2D

onready var player = $Sprite
onready var animation_player = $AnimationPlayer
onready var camera = $Camera2D


signal hit(dmg,obj)

var speed = 200
var max_air_speed = speed # ghost 

var velocity = Vector2(0,0)
var is_moving = false
var current_animation = "start"
var current_direction = "right"
var new_animation
var new_direction = ""


enum STATES {WALK,IDLE,ATTACK,SKILL,HURT,DEAD}
var current_state
var new_state

var  dmg_obj

func _ready():
	dmg_obj = DmgObj.new()
	
	camera.position = player.position

func get_input():
	velocity = Vector2(0,0)
	is_moving = false
	new_animation = current_animation
	if Input.is_action_pressed("left"):
		velocity.x += -1
		new_direction = "left"
		new_animation = "walk_left"
		is_moving = true
		
	if Input.is_action_pressed("right"):
		velocity.x += 1
		new_direction = "right"
		new_animation = "walk_right"
		is_moving = true
	if Input.is_action_pressed("up"):
		velocity.y += -1
		new_direction = "up"
		new_animation = "walk_up"
		is_moving = true		
	if Input.is_action_pressed("down"):
		velocity.y += 1
		new_direction = "down"
		new_animation = "walk_down"
		is_moving = true
	# velocity
	if velocity.length() > 0 :
		velocity = velocity.normalized() * speed
		add_ghost()
		
	# update
	update_direction(new_direction)
	update_animation(is_moving,new_animation)
	
func add_ghost():
	var ghost = preload("res://objects/Ghost.tscn").instance()
	ghost.add_child($Sprite.duplicate())
	ghost.set("position",get("position"))
	ghost.alfa_factor = 1
	ghost.live_time = 0.2
	ghost.color = Color(0.5,0,0.9)
	get_parent().add_child(ghost)
	get_parent().move_child(ghost,get_position_in_parent())	

func _physics_process(delta: float) -> void:
	get_input()
	velocity = move_and_slide(velocity)
#	$Attack_Area2D.position = velocity.normalized() * 16
#		player.position += velocity.normalized() * speed * delta
	update_camera_position()

func update_direction(new_direction):
	current_direction = new_direction

	
func update_animation(is_moving,new_animation):
	if is_moving and current_animation != new_animation :
		animation_player.current_animation = new_animation
		animation_player.play(new_animation)
		current_animation = new_animation
	elif ! is_moving and current_animation != "start" :
		animation_player.stop()
		current_animation = 'start'			
		
func _input(event: InputEvent) -> void:
#	hit(5)
	pass

var max_hp = 100
var current_hp = 100
var hurt = 5

func hit(damage):
	animation_player.play("slash_" + current_direction)
	print_debug(current_direction)

func _on_attack(damage):
	current_hp -= damage
	
	if current_hp <= 0 :
		current_hp = 0
		current_state = STATES.DEAD
		animation_player.play("hurt")
	print_debug(current_hp/max_hp * 100)
	$HP_TextureProgress.value = (current_hp * 100/max_hp)
		
func update_camera_position():
	camera.position = player.position		
	
	
		

func _on_Attack_Area2D_body_entered(body: PhysicsBody2D) -> void:
	if body and body.has_method("on_attack") :
		body.on_attack(5,self)
		var jump_name = preload("res://addons/TriggerSystem/BattleSystem/jumps/JumpName.tscn").instance()
		add_child(jump_name)
		jump_name.start("罗汉拳",Vector2(-24,-54),Color.red)
	pass # Replace with function body.
