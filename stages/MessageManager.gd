extends Control

func _ready():
	Signals_manager.connect("message_vision",self,"_on_message_vision")
	Signals_manager.connect("notify_fail",self,"_on_notify_fail")
	
func _on_message_vision(message,ob):
	print_debug(message)
	$MessageVision/RichTextLabel.bbcode_text = message	
	
func _on_notify_fail(message):
	print_debug(message)
	$Notify_fail.show()
	$Notify_fail.dialog_text = message	