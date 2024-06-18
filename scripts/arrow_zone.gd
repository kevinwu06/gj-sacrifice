extends Area2D

@onready var timer: Timer = $Timer
var target:Node2D

func _on_body_entered(body: Node2D) -> void:
	if !target:	
		target=body
		timer.start()

func _process(delta: float) -> void:
	pass

func _on_timer_timeout() -> void:
	if target is Player:
		Globals.reload_world() 
		#Global 设成了会自动加载的场景，所以可以直接用Global.里面的函数，参考globals.gd
	else:
		target.die()
	
