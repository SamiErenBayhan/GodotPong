extends CharacterBody2D

var speed: float = 400.0
var direction: Vector2 = Vector2.ZERO
const START_SPEED: float = 400.0
var is_resetting: bool = false
const MAX_SPEED: float = 1000.0

func _ready() -> void:
	start_random_movement()
	
func _physics_process(delta):
	var collision = move_and_collide(direction * speed * delta)
	
	if collision:
		direction = direction.bounce(collision.get_normal())
		if collision.get_collider().name.contains("LeftPlayer") or collision.get_collider().name.contains("RightPlayer"):
			speed = clamp(speed * 1.05, START_SPEED, MAX_SPEED )
			
		
func reset_ball() -> void:
	if is_resetting:
		return
	is_resetting = true	
	
	global_position = Vector2(-8, 24)
	velocity = Vector2.ZERO
	speed = 0.0
	
	await get_tree().create_timer(1.0).timeout
	
	speed = START_SPEED
	start_random_movement()
	is_resetting = false

func start_random_movement():
	var random_x = -1.0 if randf() < 0.5 else 1.0
	var random_y = randf_range(-0.5, 0.5)
	direction = Vector2(random_x, random_y).normalized()
