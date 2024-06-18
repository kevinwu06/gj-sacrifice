extends State
class_name PlayerJump

@onready var player: Player = $"../.."

func enter():
	player.velocity.y=player.JUMP_VELOCITY
	player.jump_request_timer.stop()

func exit():
	pass
	
func update(delta:float):
	if player.is_on_floor():
		Transitioned.emit(self,"idle")

func physics_update(delta:float):
	player.move(player.gravity,delta)
