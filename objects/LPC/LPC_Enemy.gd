extends KinematicBody2D

var hp_max = 100
var hp_current = 100

var velocity = Vector2()

onready var animation_player = $AnimationPlayer

func _ready():
	pass


func on_attack(damage,obj):
	hp_current -= damage

	if hp_current <= 0 :
		hp_current = 0
#		current_state = STATES.DEAD
		animation_player.play("hurt")
#	print_debug(hp_current/hp_max * 100)
	$HP_TextureProgress.value = hp_current * 100/hp_max
	velocity = (self.position - obj.position ).normalized() * damage * 10

	play_animation("blast001")
#	$Label.text = str(self.position)
	
func play_animation(name):
	$AnimatedSprite.show()
	$AnimatedSprite.frame = 1
	$AnimatedSprite.play(name)
	yield($AnimatedSprite,"animation_finished")
	$AnimatedSprite.hide()	
	
func _physics_process(delta: float) -> void:
	velocity = move_and_slide(velocity)