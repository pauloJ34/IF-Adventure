extends KinematicBody2D

var distancia_roda = 80
var agulo_dire = 15
var potencia = 400
var friction=-0.9
var arraste=-0.001
var parar = -350
var velocidade_escurregar=200
var velocidade_reversa_maxima = 100

var traction_rapida=0.2
var traction_devagar=0.7

var velocidade_maxima = 400

var acelera=Vector2.ZERO
var velocidade = Vector2.ZERO
var na_dire
	
func _physics_process(delta):
	acelera=Vector2.ZERO
	
	get_input()
	aplica_friction()
	calcular_dire(delta)
	velocidade+=acelera*delta
	#print(rotation_degrees)
	velocidade = move_and_slide(velocidade)
	#print(velocidade.length())
	
func aplica_friction():
	if velocidade.length()<4:
		velocidade=Vector2.ZERO
	var forca_friction = velocidade*friction
	var forca_arraste = velocidade*velocidade.length() * arraste
	acelera += forca_arraste + forca_friction
	
func get_input():
	var turn = 0
	
	if Input.is_action_pressed("ui_up"):
		acelera= transform.x * potencia
		
	if Input.is_action_pressed("freiar"):
		acelera= transform.x * parar
	
	if Input.is_action_pressed("ui_right"):
		turn+=1
		if arraste >= -0.005:
			arraste+= -0.0001

	elif Input.is_action_pressed("ui_left"):
		turn-=1
		if arraste >= -0.005:
			arraste+= -0.0001
	else:
		arraste=-0.001
		
	print(arraste)
	print(velocidade.length())

	na_dire = turn * deg2rad(agulo_dire)
	#na_dire = ( Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left") ) * deg2rad(agulo_dire)
	
	#if na_dire ==0:
	#	angulo=int(rotation_degrees)
	#	var multiplo = angulo % 45
	#	var multplicador = angulo / 90
	#	print(multiplo)
	#	if multiplo !=44 :
	#		if ((multiplo < -24 and multiplo > -44) or (multiplo > 0 and multiplo <= 24) ) and multiplo!=0:
	#			rotation_degrees -=0.5
	#		if ((multiplo > 24 and multiplo < 4) or (multiplo < 0 and multiplo >= -24) ) and multiplo!=0:
	#			rotation_degrees +=0.5
			
			
	
		
func calcular_dire(delta):
	var pneu_atras = position - transform.x * distancia_roda/2.0
	var pneu_frente = position + transform.x * distancia_roda/2.0
	
	pneu_atras += velocidade * delta
	pneu_frente += velocidade.rotated(na_dire) * delta
	var novo_heading = (pneu_frente - pneu_atras).normalized()
	var angulo_head = novo_heading.dot(velocidade.normalized())
	
	var tration = traction_devagar
	
	if velocidade.length() > velocidade_escurregar:
		tration = traction_rapida
	if angulo_head > 0:
		velocidade = velocidade.linear_interpolate(novo_heading * velocidade.length(),tration)
	if angulo_head < 0:
		velocidade = -novo_heading * min(velocidade.length(),velocidade_reversa_maxima)
	#velocidade=novo_heading * velocidade.length()
	rotation = novo_heading.angle()
