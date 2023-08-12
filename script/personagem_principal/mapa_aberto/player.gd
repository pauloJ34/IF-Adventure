extends KinematicBody2D

onready var animation:AnimationPlayer = get_node("Animation")

var motion= Vector2.ZERO
export(int) var speed


func _physics_process(_delta: float) -> void:
	move()

func move() -> void:

	if Input.is_action_pressed("ui_left") || Input.is_action_pressed("ui_right"):
		
		motion.x = (
			Input.get_action_strength("ui_right")-
			Input.get_action_strength("ui_left")) * speed
		motion.y = 0
		
		if motion.x > 0:
			animation.play("walk-right")
			Global.last_player_stand = 0
		else:
			animation.play("walk-left")
			Global.last_player_stand = 1
		
	elif Input.is_action_pressed("ui_up") || Input.is_action_pressed("ui_down"):
		motion.x = 0
		motion.y = (
			Input.get_action_strength("ui_down")-
			Input.get_action_strength("ui_up")) * speed
		
		if motion.y > 0:
			animation.play("walk-bottom")
			Global.last_player_stand = 2
		else:
			animation.play("walk-top")
			Global.last_player_stand = 3
			
	else:
		
		if Global.last_player_stand == 1:
			animation.play("idle-left")
		elif Global.last_player_stand == 0:
			animation.play("idle-right")
		elif Global.last_player_stand == 2:
			animation.play("idle-bottom")
		elif Global.last_player_stand == 3:
			animation.play("idle-top")
		
		motion.x = 0
		motion.y = 0
	
	motion = move_and_slide(motion)
	
