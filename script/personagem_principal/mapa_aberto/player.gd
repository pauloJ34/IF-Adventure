extends KinematicBody2D

onready var animation:AnimationPlayer = get_node("Animation")

var motion= Vector2.ZERO
export(int) var speed


func _physics_process(_delta: float) -> void:
	move()
	#print((Input.is_action_pressed("ui_up") || Input.is_action_pressed("ui_down")) and !Global.in_minigame)

func move() -> void:
	if (Input.is_action_pressed("ui_left") || Input.is_action_pressed("ui_right")) and !Global.in_minigame:
		motion.x = (
			Input.get_action_strength("ui_right")-
			Input.get_action_strength("ui_left")) * speed
		motion.y = 0
		motion = move_and_slide(motion)
		
		if motion.x > 0:
			animation.play("walk-right")
			Global.last_player_stand = 0
		elif motion.x < 0:
			animation.play("walk-left")
			Global.last_player_stand = 1
		else: 
			# quando houver uma colição o personagem não vai poder se mover mais na direção onde tem a colição
			if Input.is_action_pressed("ui_left"):
				animation.play("idle-left")
				Global.last_player_stand = 1
			else: 
				animation.play("idle-right")
				Global.last_player_stand = 0
		
	elif (Input.is_action_pressed("ui_up") || Input.is_action_pressed("ui_down")) and !Global.in_minigame:
		motion.x = 0
		motion.y = ( 
			Input.get_action_strength("ui_down")-
			Input.get_action_strength("ui_up")) * speed
		motion = move_and_slide(motion)
		
		if motion.y > 0:
			animation.play("walk-bottom")
			Global.last_player_stand = 2
		elif motion.y < 0:
			animation.play("walk-top")
			Global.last_player_stand = 3
		else:  
			#quando houver uma colição o personagem não vai poder se mover mais na direção onde tem a colição
			if Input.is_action_pressed("ui_down"):
				animation.play("idle-bottom")
				Global.last_player_stand = 2
			else: 
				animation.play("idle-top")
				Global.last_player_stand = 3
			
	else:
		motion.x = 0
		motion.y = 0
		motion = move_and_slide(motion)
		
		if Global.last_player_stand == 1:
			animation.play("idle-left")
		elif Global.last_player_stand == 0:
			animation.play("idle-right")
		elif Global.last_player_stand == 2:
			animation.play("idle-bottom")
		elif Global.last_player_stand == 3:
			animation.play("idle-top")
		elif Global.last_player_stand == 4:
			animation.play("pescando_espera_bottom")
		elif Global.last_player_stand == 5:
			animation.play("pescando_fisgado_bottom")
	
	
	
