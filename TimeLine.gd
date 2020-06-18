extends Control


# Called when the node enters the scene tree for the first time.
onready var timer = $Timer
onready var processbar = $ProcessBar
onready var player_panel = $PlayerPanel
onready var message_box = $MessageBox

var actor0 = {"name":"actor0","act":10,"side":"player"}
var actor1 = {"name":"actor1","act":10,"side":"enemy"}
var actor2 = {"name":"actor2","act":10,"side":"enemy"}
var actor3 = {"name":"actor3","act":10,"side":"enemy"}
var actors = [actor0,actor1,actor2,actor3]
var index = 0
var index_max = actors.size()

var is_turning = false

func _ready():
	timer.wait_time = 1
	timer.start()
	is_turning = true
	pass # Replace with function body.

func _process(delta):
	turning()
	
func turning():
	if is_turning :
		processbar.value += 1

func actor_turn():
	print_debug(actors[index].name)
	message_box.bbcode_text += actors[index].name + "\n"
	if actors[index].side == "player" :
		player_panel.show()


func _on_Timer_timeout():
	index = (index + 1)%index_max
	is_turning = false
	timer.paused = true
	actor_turn()
	pass # Replace with function body.


func _on_Button_pressed():
	timer.paused = false
	player_panel.hide()
	pass # Replace with function body.
