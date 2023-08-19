extends KinematicBody2D


var aceleracao = Vector2 (35,0)
var desaceleracao = Vector2 (-25.0,0)
var velocidade = Vector2.ZERO
var velocidadeMaxima = 125
var friccao = 0.5
var capacidadeFreios = 12.5
const rotacao = PI / 4


func _ready():
	pass 

func _physics_process(delta):
	moverCart()

func moverCart():
	acelerar()
	darRe()
	freiar()
	direcao()
	friccao()
	move_and_slide(velocidade)

func direcao():
	if !velocidade:
		pass
	else: 
		if Input.is_action_just_released("virarDireita"):
			velocidade = velocidade.rotated(rotacao)
			aceleracao = aceleracao.rotated(rotacao)
			desaceleracao = desaceleracao.rotated(rotacao)
			rotation += rotacao
		if Input.is_action_just_released("virarEsquerda"):
			velocidade = velocidade.rotated(-rotacao)
			aceleracao = aceleracao.rotated(-rotacao)
			desaceleracao = desaceleracao.rotated(-rotacao)
			rotation -= rotacao

func freiar():
	if Input.is_action_just_released("freiar"):
		if !velocidade:
			pass
		else:
			velocidade = velocidade.move_toward(Vector2.ZERO, capacidadeFreios)

func acelerar():
	if Input.is_action_just_released("acelerar"):
		velocidade += aceleracao
		velocidade = velocidade.limit_length(velocidadeMaxima)

func darRe():
	if Input.is_action_just_released("ré"):
		velocidade += desaceleracao
		velocidade = velocidade.limit_length(velocidadeMaxima)

func friccao():
	if !velocidade:
		pass
	else:
		velocidade = velocidade.move_toward(Vector2.ZERO, friccao)
