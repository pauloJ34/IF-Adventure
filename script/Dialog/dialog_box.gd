extends NinePatchRect

onready var text = $text

export var msg_queue: Array

func _ready():
	text.text = ""

func add_message(_msg: Array):
	msg_queue.append_array(_msg)	
	
func show_message():
	if msg_queue.size() == 0:
		hide()
		return
	var _msg: String = msg_queue.pop_front()
	text.text = _msg
