extends Area2D

var ondoor := false

func _ready():
	pass

func _on_Door_body_entered(body):
	if body.is_in_group("player"):
		ondoor = true
		Global.from_level = get_parent().name

func _on_Door_body_exited(body):
	if body.is_in_group("player"):	
		ondoor = false

func _process(_delta):
	if ondoor and Input.is_action_just_pressed("ui_accept"):
		#get_tree().change_scene("res://scenes/senarios/teste/"+self.name+".tscn")
		pass
