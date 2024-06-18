extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if get_parent().name=="Map1":
		Globals.go_to_world("res://scenes/title_screen.tscn")
	if get_parent().name=="level1map":
		Globals.go_to_world("res://scenes/levels/level_2_game.tscn")
	if get_parent().name=="level2map":
		Globals.go_to_world("res://scenes/levels/level_3_game.tscn")
	if get_parent().name=="level3map":
		Globals.go_to_world("res://scenes/levels/level_4_game.tscn")
	if get_parent().name=="level4map":
		Globals.go_to_world("res://scenes/levels/level_5_game_ending.tscn")
	if get_parent().name=="level5map":
		Globals.go_to_world("res://scenes/title_screen.tscn")
