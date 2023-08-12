extends KinematicBody2D

const friction = 2
const acceleration = 10
var velocity = Vector2.ZERO
var direction = 0
export var max_speed = 100
export var direction_speed = 0.04

func _ready():
	pass 

func _physics_process(delta):
	direction = 0
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_up")
	if input_vector != Vector2.ZERO:
		velocity += (input_vector * acceleration ).rotated(rotation)
		velocity = velocity.clamped(max_speed )
	else:
		velocity = velocity.move_toward(Vector2.ZERO, friction)
	if velocity != Vector2.ZERO:
		direction = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	rotation += direction * direction_speed 
	velocity = move_and_slide(velocity)


