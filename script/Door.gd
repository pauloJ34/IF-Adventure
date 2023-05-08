extends Area2D

var ondoor := false

func _ready():
	pass

func _on_Door_body_entered(_body)->void:
	ondoor = true

func _on_Door_body_exited(_body):
	ondoor = false

func _process(_delta):
	if ondoor and Input.is_action_just_pressed("ui_accept"):
		get_tree().change_scene("res://scenes/"+self.name+".tscn")
