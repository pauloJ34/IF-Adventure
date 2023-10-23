extends Area2D

export var ordem_escada:int
export var movimentar_Y:int = 12
export var movimentar_X:int = 6
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func entrada(body):
	if position.x > body.position.x and ordem_escada < 0:
		body.position.y -= movimentar_Y
		body.position.x += movimentar_X
	elif position.x < body.position.x and ordem_escada > 0:
		body.position.y += movimentar_Y
		body.position.x -= movimentar_X
		
	

func saida(body):
	if position.x < body.position.x:
		body.position.y -= movimentar_Y
		body.position.x += movimentar_X
	elif position.x > body.position.x:
		body.position.y += movimentar_Y
		body.position.x -= movimentar_X
		


func _on_Area2D_body_entered(body):
	entrada(body)
	#else:
	#	body.position.y -= 16
func _on_Area2D_body_exited(body):
	#body.position.y += 16
	saida(body)

#func _on_Area2D2_body_entered(body):
#	entrada(body)

#func _on_Area2D3_body_entered(body):
#	entrada(body)

#func _on_Area2D2_body_exited(body):
#	saida(body)

#func _on_Area2D3_body_exited(body):
#	saida(body)
