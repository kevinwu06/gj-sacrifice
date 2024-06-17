extends Area2D

@onready var timer: Timer = $Timer

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		print("Player Died!")
		timer.start()
	else:
		body.die

func _on_timer_timeout() -> void:
	get_tree().reload_current_scene()
