extends CharacterBody2D

const PADDLE_SPEED = 500

func _physics_process(delta):
	var direction = Input.get_axis("ui_up", "ui_down")
	if direction:
		velocity.y = direction * PADDLE_SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, PADDLE_SPEED)
	move_and_slide()
	
