extends KinematicBody2D

var velocity = Vector2.ZERO
var direction = 0
export var speed = 100
export var direction_speed = 1.5

func _ready():
	pass 

func _physics_process(delta):
	velocity = Vector2.ZERO
	direction = 0
	if Input.is_action_pressed("ui_up"):
		velocity = Vector2(speed,0).rotated(rotation)
		if Input.is_action_pressed("ui_left"):
			direction = 1
		elif Input.is_action_pressed("ui_right"):
			direction = -1
		else:
			direction = 0
	else:
		direction = 0
		
	rotation += direction * direction_speed * delta
	velocity = move_and_slide(velocity)

