extends Control

@onready var color_rect = $ColorRect
@onready var story_label = $Story
@onready var skip_label = $SkipTip
@onready var timer = $Timer

var story_data = [
	["第一段的第一句。", "第一段的第二句。", "第一段的第三句。"],
	["第二段的第一句。", "第二段的第二句。", "第二段的第三句。"]
]

var current_paragraph = 0
var current_sentence = 0
var is_skipping = false
var skip_timer = 0.0
var skip_threshold = 1  # 长按1秒跳过

func _ready():
	color_rect.color = Color(0, 0, 0, 1)
	story_label.text = ""
	skip_label.text = "长按空格跳过"
	skip_label.visible = false
	timer.wait_time = 2.5  # 调整句子之间的间隔时间
	timer.connect("timeout", Callable(self, "_on_timeout"))
	
	show_next_sentence()

func _process(delta):
	if Input.is_action_pressed("ui_accept"):  # 空格键
		skip_label.visible = true
		skip_timer += delta
		if skip_timer >= skip_threshold:
			_skip_story()
	else:
		skip_timer = 0
		skip_label.visible = false

func show_next_sentence():
	if current_paragraph < story_data.size():
		if current_sentence < story_data[current_paragraph].size():
			var sentence = story_data[current_paragraph][current_sentence]
			story_label.text += sentence + "\n"  # 直接添加新句子到文本中
			current_sentence += 1
			timer.start()
			await timer.timeout
			show_next_sentence()
		else:
			# 当前段落已结束，等待并清除文本，然后显示下一个段落
			timer.start()
			await timer.timeout
			story_label.text = ""  # 清除文本
			await delay(0.5)
			current_paragraph += 1
			current_sentence = 0
			show_next_sentence()
	else:
		_on_animation_finished()

func _on_animation_finished():
	Globals.go_to_world("res://scenes/levels/level_1_game_prologue.tscn")

func _skip_story():
	Globals.go_to_world("res://scenes/levels/level_1_game_prologue.tscn")

# 延迟函数
func delay(seconds):
	var timer = Timer.new()
	timer.wait_time = seconds
	timer.one_shot = true
	add_child(timer)
	timer.start()
	await timer.timeout
	remove_child(timer)
