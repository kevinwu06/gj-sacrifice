extends State
class_name PlayerIdle

@onready var player: Player = $"../.."

func enter():
	pass

func exit():
	pass
	
func update(delta:float):
	var direction=Input.get_axis("move_left","move_right")
	var is_still=is_zero_approx(direction)and is_zero_approx(player.velocity.x)
	
	if not is_still:
		Transitioned.emit(self,"move")

func physics_update(delta:float):
	player.move(player.gravity,delta)
