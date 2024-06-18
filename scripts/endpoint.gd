extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if get_parent().name=="Map1":
		Globals.go_to_world("res://scenes/title_screen.tscn")
	
