extends HScrollBar

export var inicio_fim:bool = true
var rodando = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		rodando = !rodando
		#meio de ganhar
		if 45 >= value-page and value-page <= 70:
			print("ganhou!!")
			Global.tempo_fisgar = -1
		else:
			print("perdeu!")
	if inicio_fim and rodando: 
		value += 100*delta
		if value >= 100-page:
			inicio_fim = !inicio_fim
	elif !inicio_fim and rodando:
		value -= 100*delta
		if value <= 0:
			inicio_fim = !inicio_fim
	#	pass
