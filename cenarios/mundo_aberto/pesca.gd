extends Area2D
var rng = RandomNumberGenerator.new()
var barra 

#var scene = preload("res://cenarios/mundo_aberto/interface/barra.tscn")
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var colid = false
var ver = false
var fisgar_tempo= 200
export(int) var player_pesca_valor = 4
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#print(get_node("../YSort/player").add_child(scene))
	
		
	if colid and Input.is_action_just_pressed("ui_accept") and !ver:
		Global.tempo_fisgar = 1
	elif colid and Input.is_action_just_released("ui_cancel"):
		if is_instance_valid(barra):
			ver = false
			Global.tempo_fisgar = 0
			Global.last_player_stand = 3
			barra.queue_free()
			
	elif Global.tempo_fisgar == -1:
		ver = false
		Global.tempo_fisgar = 0
		Global.last_player_stand = 3
		barra.queue_free()
		
	elif colid and Global.tempo_fisgar!=0 and fisgar_tempo!=Global.tempo_fisgar: 
		Global.tempo_fisgar=rng.randi_range(1,fisgar_tempo)
		Global.last_player_stand = player_pesca_valor
		#print(Global.tempo_fisgar)
		if fisgar_tempo==Global.tempo_fisgar:
			barra = preload("res://cenarios/mundo_aberto/interface/barra.tscn").instance()
			get_node("../YSort/player").add_child(barra)
			ver = true
	elif colid and fisgar_tempo==Global.tempo_fisgar:
		Global.last_player_stand = (player_pesca_valor + 1)
		
		
		
#	pass


func _on_Area2D_body_entered(body):
	colid = true

func _on_Area2D_body_exited(body):
	colid = false

