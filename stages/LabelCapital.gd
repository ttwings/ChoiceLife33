extends Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
var value = randi()%300000

var time = 230 + randi()%100
func _process(delta: float) -> void:
	time = time - 1
	if time <= 0 :
		time = 230 + randi()%100
		value += randi()%500
		self.text = "资金" + str(value).format("%09d") + "钱"
