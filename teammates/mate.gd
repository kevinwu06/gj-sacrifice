class_name Mate
extends CharacterBody2D

enum Direction{
	LEFT=-1,
	RIGHT=+1,
}

@onready var state_machine: Node = $StateMachine
@onready var graphics: Node2D = $Graphics
@export var direction=Direction.LEFT:
	set(v):
		direction=v
		if not is_node_ready():
			await ready
		graphics.scale.x=-direction
		
func holded()->void:
	if state_machine:
		var current_state = state_machine.current_state
		if current_state:
			if current_state is IDLE:
				current_state.Transitioned.emit(current_state,"hold")
			else:
				current_state.Transitioned.emit(current_state,"idle")
	
func die():
	var current_state = state_machine.current_state
	current_state.Transitioned.emit(current_state,"died")

func throwed():
	var current_state = state_machine.current_state
	if current_state is HOLD:
		current_state.Transitioned.emit(current_state,"throwed")

