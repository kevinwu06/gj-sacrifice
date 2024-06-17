extends State
class_name THROWED

@export var mate: CharacterBody2D
var player: CharacterBody2D

var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")
const SPEED=10

func enter():
	player = mate.get_parent().get_node("Player")
	mate.velocity.x=player.velocity.x*1.5
	mate.velocity.y=-200
	pass

func exit():
	pass
	
func update(delta:float):
	pass

func physics_update(delta:float):
	if not mate.is_on_floor():
		mate.velocity.y += gravity * delta
	
	if mate.is_on_floor()&&mate.velocity.y==0:
		Transitioned.emit(self,"idle")
		
	mate.velocity.x = move_toward(mate.velocity.x, 0, SPEED)
	
	mate.move_and_slide()

