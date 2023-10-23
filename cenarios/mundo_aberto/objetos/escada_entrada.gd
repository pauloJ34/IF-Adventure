extends Area2D

export var altura:int = 8
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_degral_entrada_1_body_entered(body):
	if position.y < body.position.y:
		body.position.y -= altura
	else:
	# position.y > body.position.y:
		body.position.y += altura
		

