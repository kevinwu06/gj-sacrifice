extends State
class_name HOLD

@export var mate: CharacterBody2D
var player: CharacterBody2D

func enter():
	player = mate.get_parent().get_node("Player")

func exit():
	pass
	
func physics_update(delta:float)->void:
	if player:
		mate.position=player.position
		mate.position.y-=25
