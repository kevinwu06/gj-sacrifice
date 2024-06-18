class_name Player
extends CharacterBody2D


const RUN_SPEED = 300.0
const JUMP_VELOCITY = -400.0
const FLOOR_ACCELERATION=RUN_SPEED/0.05
const AIR_ACCELERATION=RUN_SPEED/0.1

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var graphics: Node2D = $Graphics
@onready var jump_request_timer: Timer = $JumpRequestTimer
@onready var state_machine: Node = $StateMachine

var mate:Mate

#检测输入
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("jump"):
		jump_request_timer.start()
		
	if event.is_action_released("jump"):
		jump_request_timer.stop()
		if velocity.y<JUMP_VELOCITY/2:
			velocity.y=JUMP_VELOCITY/2

func move(gravity:float,delta:float)->void:
	#移动
	var direction=Input.get_axis("move_left","move_right")
	var acceleration=FLOOR_ACCELERATION if is_on_floor() else AIR_ACCELERATION
	velocity.x=move_toward(velocity.x,direction*RUN_SPEED,acceleration*delta)
	velocity.y+=gravity*delta
	#方向切换
	if not is_zero_approx(direction):
		graphics.scale.x= -1 if direction<0 else +1
	move_and_slide()

func _process(delta:float):
	var should_jump=is_on_floor() and jump_request_timer.time_left>0
	if should_jump:
		var current_state=state_machine.current_state
		return current_state.Transitioned.emit(current_state,"jump")
		
func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_hold"):
		#var mate1 = get_parent().get_node("Mate1")
		if mate:
			mate.holded()
			
	if Input.is_action_just_pressed("ui_throw"):
		#var mate1 = get_parent().get_node("Mate1")
		if mate:
			mate.throwed()


func _on_area_2d_body_entered(body: Node2D) -> void:
	print("body entered")
	if mate:
		return
	if body is Mate:
		print("body is mate")
		mate=body

func _on_area_2d_body_exited(body: Node2D) -> void:
	print("body exited")
	if body==mate:
		mate=null
