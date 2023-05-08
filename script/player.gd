extends KinematicBody2D

onready var animation:AnimationPlayer = get_node("Animation")

var motion= Vector2.ZERO

export(int) var speed
var direction_stop:int

func _physics_process(_delta: float) -> void:
	move()

func move() -> void:
	
	if Input.is_action_pressed("ui_left") || Input.is_action_pressed("ui_right"):
		motion.x = (
			Input.get_action_strength("ui_right")-
			Input.get_action_strength("ui_left")) * speed
		motion.y = 0
		
		if motion.x > 0:
			animation.play("run-right")
			direction_stop = 1
		else:
			animation.play("run-left")
			direction_stop = 0
		
	elif Input.is_action_pressed("ui_up") || Input.is_action_pressed("ui_down"):
		motion.x = 0
		motion.y = (
			Input.get_action_strength("ui_down")-
			Input.get_action_strength("ui_up")) * speed
		
		if motion.y > 0:
			animation.play("run-bottom")
			direction_stop = 2
		else:
			animation.play("run-top")
			direction_stop = 3
			
	else:
		
		if direction_stop == 0:
			animation.play("idle-left")
		elif direction_stop == 1:
			animation.play("idle-right")
		elif direction_stop == 2:
			animation.play("idle-bottom")
		elif direction_stop == 3:
			animation.play("idle-top")
		motion.x = 0
		motion.y = 0
	
	motion = move_and_slide(motion)
	
