extends State
class_name IDLE

@onready var floor_checker: RayCast2D = $"../../Graphics/FloorChecker"
@export var mate: CharacterBody2D
var player: CharacterBody2D

const BASE_SPEED = 100.0  # 基础速度
const MAX_SPEED = 200.0   # 最大速度（稍微减小）
const ACCELERATION = 500.0  # 加速度
const DECELERATION = 500.0  # 减速度
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
	var distance = player.position.x - mate.position.x
	var direction = sign(distance)
	mate.direction = -direction
	distance = abs(distance)

	var target_speed = 0.0

	if distance > follow_distance:
		target_speed = lerp(BASE_SPEED, MAX_SPEED, distance / follow_distance)
	else:
		target_speed = 0.0

	var acceleration = ACCELERATION if target_speed > abs(mate.velocity.x) else DECELERATION
	mate.velocity.x = move_toward(mate.velocity.x, direction * target_speed, acceleration * delta)

	# 确保mate在地面上时才更新速度
	if floor_checker.is_colliding():
		mate.velocity.x = mate.velocity.x
	else:
		mate.velocity.x = move_toward(mate.velocity.x, 0, BASE_SPEED * delta)
