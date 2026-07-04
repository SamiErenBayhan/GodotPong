extends Node2D

var left_score = 0
var right_score = 0
@export var ball_node: CharacterBody2D
const max_score: int = 5
@onready var left_ui = $LeftPlayerWin
@onready var right_ui = $RightPlayerWin
@onready var win_sound = $RightScoreArea/WinSound
@onready var level_up_sound = $RightScoreArea/LevelUpSound

func _ready() -> void:
	left_ui.visible = false
	right_ui.visible = false

func _on_right_score_area_body_entered(body: Node2D) -> void:
	if body.name.contains("Ball"):
		var old_score = right_score
		right_score += 1
		if right_score > old_score and right_score < max_score:
			level_up_sound.play()
		$RightScoreArea/Label.text = str(right_score)
		if right_score >= max_score:
			left_ui.visible = true
			win_sound.play()
			get_tree().paused = true
		if is_instance_valid(ball_node):
			ball_node.reset_ball()
		
func _on_left_score_area_body_entered(body: Node2D) -> void:
	if body.name.contains("Ball"):
		var old_score = left_score
		left_score += 1
		if left_score > old_score and left_score < max_score:
			level_up_sound.play()
		$LeftScoreArea/Label.text = str(left_score)
		if left_score >= max_score:
			right_ui.visible = true
			win_sound.play()
			get_tree().paused = true
		if is_instance_valid(ball_node):
			ball_node.reset_ball()
	
func _on_button_pressed() -> void:
	reset()

func reset():
	left_score = 0
	right_score = 0 
	$LeftScoreArea/Label.text = str(left_score)
	$RightScoreArea/Label.text = str(left_score)
	get_tree().paused = false
	right_ui.visible = false
	left_ui.visible = false
	if is_instance_valid(ball_node):
		ball_node.reset_ball()
