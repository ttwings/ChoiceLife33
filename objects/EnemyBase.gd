extends KinematicBody2D

var speed = 20
var velocity = Vector2.ZERO
var player = null


func _physics_process(delta: float) -> void:
	velocity = Vector2.ZERO
	if player :
		print(player.cname)
		velocity = position.direction_to(player.position)*speed
	velocity = move_and_slide(velocity)



func _on_DetectRadius_body_entered(body: Node) -> void:
	player = body
	print("enter")
	print(velocity)
	pass # Replace with function body.



func _on_DetectRadius_body_exited(body: Node) -> void:
	player = null
	pass # Replace with function body.


func _on_DetectRadius_area_entered(area: Area2D) -> void:
	player = area
	pass # Replace with function body.


func _on_DetectRadius_area_exited(area: Area2D) -> void:
	player = null
	pass # Replace with function body.
