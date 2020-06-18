extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export(String) var path

onready var sprite = $Sprite
onready var animal = $AnimationPlayer
onready var tween = $Tween


var next_pos
var step_size = Vector2(32,32)
var direction = Vector2(0,1) 
var directions = {	"down":Vector2(0,1),
					"up":Vector2(0,-1),
					"left":Vector2(-1,0),
					"right":Vector2(1,0)}
var state = "idle"
var dir = "up" # down
var is_idle = true # 空闲时才能接收指令。 与动画播放相对。
# Called when the node enters the scene tree for the first time.
func _ready():
	sprite.texture = load(path)
	pass # Replace with function body.

#func _process(delta):
#	if Input.action_press("ui_down") :
#		animal.play("move_down")
#		move(direction)

func _input(event):
	if is_idle and event.is_action_pressed("ui_down"):
		dir = "down"
		animal.play("move_" + dir)
		move(directions[dir])	
	if is_idle and event.is_action_pressed("ui_up"):
		dir = "up"
		animal.play("move_" + dir)
		move(directions[dir])	
	if is_idle and event.is_action_pressed("ui_left"):
		dir = "left"
		animal.play("move_" + dir)
		move(directions[dir])	
	if is_idle and event.is_action_pressed("ui_right"):
		dir = "right"
		animal.play("move_" + dir)
		move(directions[dir])	


#	pass
func get_next_pos(direction:Vector2):
	return self.position + direction*step_size


func move(direction:Vector2):
	tween.interpolate_property(self,"position",self.position,get_next_pos(direction),0.3,Tween.TRANS_LINEAR,Tween.EASE_IN)
	tween.start()
	is_idle = false
	yield(tween,"tween_completed")
	is_idle = true
	print_debug(self.position,is_idle)
