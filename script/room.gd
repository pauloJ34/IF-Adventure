extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	if Global.from_level != null :
		$YSort/player.set_position(get_node(Global.from_level + "_pos").position)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
