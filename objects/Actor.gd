extends Node2D

# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"

# Called when the node enters the scene tree for the first time.
var says = [
	"这菜真难吃,再也不到这来了",
	"勉强下咽",
	"马马虎虎了",
	"有点特色",
	"味道还不错",
	"味道棒极了",
	"味道真棒,下次要带朋友来",
	
]



func random_say():
#	randomize()
	time = 200 + randi()%100
	$Say/RichTextLabel.bbcode_text = says[randi()%says.size()]
	$AnimationPlayer.play("say")
	
#	yield($AnimationPlayer,"animation_finished")

var time = 100
func _process(delta: float) -> void:
	time = time - 1
	if time <= 0:
		random_say()
		random_move()

var moves = ["move_up","move_right","move_down","move_left"]
		
func random_move():
	$AnimationPlayer.play(moves[randi()%moves.size()])		