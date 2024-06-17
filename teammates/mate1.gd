extends CharacterBody2D
class_name Mate

@onready var state_machine: Node = $StateMachine
@onready var hold: Node = $StateMachine/HOLD

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
