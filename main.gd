extends Node2D

var left_score = 0
var right_score = 0
@export var ball_node: CharacterBody2D

func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_right_score_area_body_entered(body: Node2D) -> void:
	if body.name.contains("Ball"):
		right_score += 1
		print(right_score)
		$RightScoreArea/Label.text = str(right_score)
		if is_instance_valid(ball_node):
			ball_node.reset_ball()
			

func _on_left_score_area_body_entered(body: Node2D) -> void:
	if body.name.contains("Ball"):
		left_score += 1
		print(left_score)
		$LeftScoreArea/Label.text = str(left_score)
		if is_instance_valid(ball_node):
			ball_node.reset_ball()
