extends CharacterBody2D

# Raketin ilk/taban hızı (Top uzaktayken bu hızda çalışır)
var win_height : int
var p_height : int
const PADDLE_SPEED = 500

func _ready() -> void:
	
	win_height = get_viewport_rect().size.y
	p_height = $ColorRect.get_size().y

func _physics_process(delta):
	var direction = Input.get_axis("ui_up", "ui_down")
	if direction:
		velocity.y = direction * PADDLE_SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, PADDLE_SPEED)
	move_and_slide()
	
