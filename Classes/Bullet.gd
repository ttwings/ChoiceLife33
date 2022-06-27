extends Area2D

export(Texture) var texture
export(int) var speed = 750
onready var sprite = $Sprite
func _ready():
	sprite.texture = texture

func _physics_process(delta):
	position += transform.x * speed * delta
	


func _on_Bullet_body_entered(body):
	if body.is_in_group("mobs"):
		body.queue_free()
	queue_free()	
	pass # Replace with function body.
