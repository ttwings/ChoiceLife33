extends Label

# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
signal caption_change(value)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	connect("caption_change",self,"_on_caption_change")
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass

func _on_caption_change(value:int):
	self.text = "资金" + str(value).format("%9d") + "钱"
	pass