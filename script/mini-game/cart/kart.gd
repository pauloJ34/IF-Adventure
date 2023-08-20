extends KinematicBody2D

var atrito = 70
var agulo_dire = 45
var potencia = 200
var potencia_parar = -300
var velocidade_escurregar=100
var velocidade_maxima = 150
var velocidade_reversa_maxima = 100

var traction_rapida=0.1
var traction_devagar=0.7
var friction=-1
var arraste=-0.001

var acelera=Vector2.ZERO
var velocidade = Vector2.ZERO
var na_dire
var angulo
	
func _physics_process(delta):
	acelera=Vector2.ZERO
	
	get_input()
	aplica_friction()
	calcular_dire(delta)
	#if velocidade.length() < velocidade_maxima:
	velocidade+=acelera*delta
	#print(rotation_degrees)
	velocidade = move_and_slide(velocidade)
	#print(velocidade.length())
	
func aplica_friction():
	if velocidade.length()<3:
		velocidade=Vector2.ZERO
	var forca_friction = velocidade*friction
	var forca_arraste = velocidade*velocidade.length() * arraste
	acelera += forca_arraste + forca_friction
	
func get_input():
	na_dire = ( Input.get_action_strength("ui_right") - 
				Input.get_action_strength("ui_left") ) * deg2rad(agulo_dire)
	
	if na_dire ==0:
		angulo=int(rotation_degrees)
		var multiplo = angulo % 45
		var multplicador = angulo / 90
		print(multiplo)
		if multiplo !=44 :
			if ((multiplo < -24 and multiplo > -44) or (multiplo > 0 and multiplo <= 24) ) and multiplo!=0:
				rotation_degrees -=0.5
			if ((multiplo > 24 and multiplo < 4) or (multiplo < 0 and multiplo >= -24) ) and multiplo!=0:
				rotation_degrees +=0.5
			
			
	if Input.is_action_pressed("ui_up"):
		acelera= transform.x * potencia
	if Input.is_action_pressed("ui_down"):
		acelera= transform.x * potencia_parar
		
func calcular_dire(delta):
	var pneu_atras = position - transform.x * atrito/2.0
	var pneu_frente = position + transform.x * atrito/2.0
	
	pneu_atras += velocidade * delta
	pneu_frente += velocidade.rotated(na_dire) * delta
	var novo_heading = (pneu_frente - pneu_atras).normalized()
	var angulo_head = novo_heading.dot(velocidade.normalized())
	
	var tration = traction_devagar
	
	if velocidade.length() > velocidade_escurregar:
		tration = traction_rapida
	if angulo_head > 0:
		velocidade = velocidade.linear_interpolate(novo_heading * velocidade.length(),tration)
	else:
		velocidade = -novo_heading * min(velocidade.length(),velocidade_reversa_maxima)
	#velocidade=novo_heading * velocidade.length()
	rotation = novo_heading.angle()
