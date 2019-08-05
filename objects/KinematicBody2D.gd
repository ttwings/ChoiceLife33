extends KinematicBody2D

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("ui_down") :
		move_down()
	if Input.is_action_pressed("ui_left") :
		move_left()
	if Input.is_action_pressed("ui_right") :
		move_right()
	if Input.is_action_pressed("ui_up") :
		move_up()		
	
func move_up():
	move_and_collide(Vector2(0,-1))
	$AnimationPlayer.play("move_up")
	
func move_down():
	move_and_collide(Vector2(0,1))
	$AnimationPlayer.play("move_down")
	
func move_left():
	move_and_collide(Vector2(-1,0))
	$AnimationPlayer.play("move_left")

func move_right():
	move_and_collide(Vector2(1,0))
	$AnimationPlayer.play("move_right")