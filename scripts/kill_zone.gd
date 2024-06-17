extends Area2D

@onready var timer: Timer = $Timer

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		print("Player Died!")
		timer.start()
	else:
		body.die()

func _on_timer_timeout() -> void:
	Globals.reload_world() 
	#Global 设成了会自动加载的场景，所以可以直接用Global.里面的函数，参考globals.gd
