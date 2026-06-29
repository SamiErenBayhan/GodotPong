extends CharacterBody2D

var speed: float = 500.0

func _physics_process(delta: float) -> void:
	
	var direction = Input.get_axis("ui_up", "ui_down")
	
	if direction:
		velocity.y = direction * speed
	else:
		velocity.y = 0
	
	move_and_slide()	
		
	
