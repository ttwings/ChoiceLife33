extends KinematicBody2D

export(int) var SPEED = 16

onready var tween = $Tween

var directions = {
	'up':Vector2.UP,
	'down':Vector2.DOWN,
	'left':Vector2.LEFT,
	'right':Vector2.RIGHT
}

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
#	move_and_slide(Vector2(0,-1)*SPEED)
	$AnimationPlayer.play("move_right")
	tween.interpolate_property(self,"position",self.position,self.position + Vector2(1,0)*SPEED,0.4,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
	tween.interpolate_property(self,"position",self.position,self.position + Vector2(0,-1)*64,0.2,Tween.TRANS_CIRC,Tween.EASE_OUT_IN)
	tween.interpolate_property(self,"position",self.position,self.position + Vector2(0,1)*64,0.2,Tween.TRANS_CIRC,Tween.EASE_OUT_IN)	
	tween.start()
	print(self.position)

func move_down():
	move_and_slide(Vector2(0,1)*SPEED)
	$AnimationPlayer.play("move_down")

func move_left():
	move_and_slide(Vector2(-1,0)*SPEED)
	$AnimationPlayer.play("move_left")

func move_right():
	move_and_slide(Vector2(1,0)*SPEED)
	$AnimationPlayer.play("move_right")
	
		
