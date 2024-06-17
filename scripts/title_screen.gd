extends Control

@export var scroll_velocity = 30.0

#背景音乐
@onready var background = $ParallaxBackground
#按键声音
@onready var click_sound = $ClickSound
#切换选项和主菜单的动画
@onready var transitions = $UI/Menus/Transitions


# Called when the node enters the scene tree for the first time.
func _ready():
	_hook_button_sound(self)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	background.scroll_offset.x += scroll_velocity * delta


func _hook_button_sound(node):
	for child in node.get_children():
		if child is Button:
			child.pressed.connect(click_sound.play)
		else:
			_hook_button_sound(child)

#从主菜单打开选项
func _on_options_button_pressed():
	transitions.play("show-options")

#从选项返回主菜单
func _on_back_button_pressed():
	transitions.play_backwards("show-options")

#退出游戏
func _on_quit_button_pressed():
	get_tree().quit()

#开始游戏
func _on_start_button_pressed():
	Globals.start_game()	
