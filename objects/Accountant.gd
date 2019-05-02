extends Node

func _ready() -> void:
	check_out(12345678)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass

func check_out(value:int):
	var v = String(value)
#	$Say/RichTextLabel.rect_size = Vector2(v.length()*32,24)
	$Say/RichTextLabel.bbcode_text = "您好,一共[color=yellow]" + v + "[/color]文钱"
	pass
