extends Node2D

@export var follow_target: NodePath
@export var follow_threshold: float = 50.0  # 主角和精灵之间的最小距离
@export var max_follow_speed: float = 300.0  # 最大跟随速度
@export var float_amplitude: float = 0.5  # 上下浮动的幅度
@export var float_speed: float = 2.0  # 上下浮动的速度
@export var vertical_offset: float = 30.0  # 精灵相对于主角的垂直偏移量

var target: Node2D
var float_time: float = 0.0

func _ready():
	target = get_node(follow_target)
	if target == null:
		print("Error: Follow target not found")

func _process(delta):
	if target:
		float_time += delta * float_speed
		update_position(delta)

func update_position(delta):
	var target_pos = target.global_position + Vector2(0, -vertical_offset)  # 添加垂直偏移量
	var current_pos = global_position
	var distance = target_pos.distance_to(current_pos)

	if distance > follow_threshold:
		var direction = (target_pos - current_pos).normalized()
		var follow_speed = min(max_follow_speed, distance)  # 距离越远速度越快，但不超过最大速度
		global_position += direction * follow_speed * delta

	# 上下浮动效果
	var float_offset = sin(float_time) * float_amplitude
	global_position.y += float_offset
