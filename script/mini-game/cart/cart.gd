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

# A FUNÇÃO moverCart() É A RESPONSAVEL POR CHAMAR OS METODOS
func moverCart():
	acelerar()
	darRe()
	freiar()
	direcao()
	friccao()
	move_and_slide(velocidade)

# A FUNÇÃO direcao() É A RESPONSAVEL POR "ENROLAR" O CART
# A CADA "ENROLADA" O CART FICA APONTANDO PARA UMA DIREÇÃO ESPECIFICA
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

# A FUNÇÃO freiar() É A RESPONSAVEL POR FREIAR O CART
# TODA VEZ QUR Shift É PRECIONADO O CART PERDE BASTANTE DE SUA VELOCIDADE
func freiar():
	if Input.is_action_just_released("freiar"):
		if !velocidade:
			pass
		else:
			velocidade = velocidade.move_toward(Vector2.ZERO, capacidadeFreios)

# A FUNÇÃO acelerar() É A RESPONSAVEL POR FAZER O CART IR PARA FRENTE
# TODA VEZ QUE w É PRECIONADO O CART RECEBE UMA ACELERAÇAO POSITIVA, OU SEJA, VAI PARA FRENTE
func acelerar():
	if Input.is_action_just_released("acelerar"):
		velocidade += aceleracao
		velocidade = velocidade.limit_length(velocidadeMaxima)

# A FUNÇÃO darRe() É A RESPONSAVEL POR FAZER O CART IR PARA TRAZ
# TODA VEZ QUE s É PRECIONADO O CART RECEBE UMA ACELERAÇÃO NEGATIVA, OU SEJA, VAI PARA TRAZ
func darRe():
	if Input.is_action_just_released("ré"):
		velocidade += desaceleracao
		velocidade = velocidade.limit_length(velocidadeMaxima)

# A FUNÇÃO friccao() É A RESPONSAVEL POR RETIRAR E DIFICULTAR A VELOCIDADE DO CART
# E ELA ACONTECE A TODO ESTANTE
func friccao():
	if !velocidade:
		pass
	else:
		velocidade = velocidade.move_toward(Vector2.ZERO, friccao)
