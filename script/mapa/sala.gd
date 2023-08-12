extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# script para mudança de cenario
func _ready():
	if Global.from_level != null :
		$YSort/player.set_position(get_node(Global.from_level + "_pos").position)

