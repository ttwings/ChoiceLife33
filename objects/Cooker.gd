extends Node

# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text".
var dishes = []
func _ready() -> void:
	dishes = Global.load_data("res://data/dishes.json")
	print_debug(dishes)
	
var says = [
	"[color=yellow]{name}[/color]好咯!",
	"小二,上菜[color=yellow]{name}[/color]",
	"新鲜出炉的[color=yellow]{name}[/color]咯",
	"[color=yellow]{name}[/color]简直杰作!",
	"超水平发挥[color=yellow]{name}[/color]",
	"[color=yellow]{name}[/color]味道包管满意",
	"[color=yellow]{name}[/color]嗯,再放点盐",
	"[color=yellow]{name}[/color]不够辣"
]
func random_say():
	randomize()
	dishes.shuffle()
	var dish = dishes.front()
	time = 200 + randi()%100
	$Say/RichTextLabel.bbcode_text = says[randi()%says.size()].format({"name":dish.name})
	$AnimationPlayer.play("say")

var time = 100
func _process(delta: float) -> void:
	time = time - 1
	if time <= 0:
		random_say()
