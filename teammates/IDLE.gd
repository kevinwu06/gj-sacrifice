extends State
class_name IDLE

@export var mate: CharacterBody2D
var player: CharacterBody2D

const SPEED = 100.0
const JUMP_VELOCITY = -400.0
var follow_distance = 100
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")
	
func enter():
	player = mate.get_parent().get_node("Player")
	
func physics_update(delta: float) -> void:
	if not mate.is_on_floor():
		mate.velocity.y += gravity * delta

	if player:
		follow_player(player, delta)
		
	mate.move_and_slide()	 


func follow_player(player, delta):
	var distance = (player.position.x - mate.position.x)
	var direction
	if distance>0:
		direction=1
	else:
		direction=-1;
	distance=abs(distance)
	
	if distance > follow_distance:
		mate.velocity.x = direction * SPEED
	else:
		mate.velocity.x = move_toward(mate.velocity.x, 0, SPEED)
