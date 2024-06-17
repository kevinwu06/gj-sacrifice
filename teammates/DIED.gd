extends State
class_name DIED

@export var mate: CharacterBody2D

const SPEED = 100.0
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")

func enter():
	mate.collision_layer=1
	pass

func exit():
	mate.collision_layer=2
	pass
	
func update(delta:float):
	pass

func physics_update(delta:float):
	if not mate.is_on_floor():
		mate.velocity.y += gravity * delta
	
	mate.velocity.x = move_toward(mate.velocity.x, 0, SPEED)
	
	mate.move_and_slide()

