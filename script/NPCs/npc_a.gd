extends KinematicBody2D

export(Resource) var interation

func _ready():
	$speech_bubble/dialog_box.add_message(interation.msg_queue)
	$speech_bubble/dialog_box.show_message()

func _on_body_entered(body):
	if body.is_in_group("player"):
		$speech_bubble.show()
	pass # Replace with function body.


func _on_body_exited(body):
	if body.is_in_group("player"):
		
		$speech_bubble.hide()
	pass
