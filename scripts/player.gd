class_name Player
extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")

var mate:Mate

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	if Input.is_action_just_pressed("ui_hold"):
		#var mate1 = get_parent().get_node("Mate1")
		if mate:
			mate.holded()
			
	if Input.is_action_just_pressed("ui_throw"):
		#var mate1 = get_parent().get_node("Mate1")
		if mate:
			mate.throwed()

	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()


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
