extends KinematicBody2D

export(int) var SPEED = 16

onready var tween = $Tween

# 注意物理的运动和其他的不一致。
func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("ui_down") :
		move_down()
	if Input.is_action_pressed("ui_left") :
		move_left()
	if Input.is_action_pressed("ui_right") :
		move_right()
	if Input.is_action_pressed("ui_up") :
#		move_up()
		$MovePlayer.play("move_up")

func move_up():
	move_and_slide(Vector2(0,-1)*SPEED)
	$AnimationPlayer.play("move_right")

func move_down():
	move_and_slide(Vector2(0,1)*SPEED)
	$AnimationPlayer.play("move_down")

func move_left():
	move_and_slide(Vector2(-1,0)*SPEED)
	$AnimationPlayer.play("move_left")

func move_right():
	move_and_slide(Vector2(1,0)*SPEED)
	$AnimationPlayer.play("move_right")
	
		
