extends CharacterBody2D

var speed: float = 400.0
const START_SPEED: float = 400.0
const MAX_SPEED: float = 1100.0
var direction: Vector2 = Vector2.ZERO
@onready var hit_sound = $HitSound
var is_resetting: bool = false

func _ready() -> void:
	start_random_movement()

func _physics_process(delta):
	if is_resetting:
		return
		
	var collision = move_and_collide(direction * speed * delta)
	if collision:
		var collider = collision.get_collider()
		if collider.name.contains("LeftPlayer") or collider.name.contains("RightPlayer"):
			speed = clamp(speed * 1.1, START_SPEED, MAX_SPEED)
			if "velocity" in collider:
				collider.velocity = Vector2.ZERO
			var relative_intersect_y = global_position.y - collider.global_position.y
			var normalized_intersect_y = clamp(relative_intersect_y / 64, -1.0, 1.0)
			var new_x_direction = -1.0 if direction.x > 0 else 1.0
			direction = Vector2(new_x_direction, normalized_intersect_y).normalized()
			hit_sound.play()
		else:
			direction = direction.bounce(collision.get_normal())
			hit_sound.play()
		
		#move_and_collide fonksiyonunun yarattığı yapışma problemini çözmek için yaptık
		var remainder = collision.get_remainder()
		move_and_collide(direction * remainder.length())

func reset_ball() -> void:
	if is_resetting:
		return
	is_resetting = true

	global_position = Vector2(-8, 24)
	direction = Vector2.ZERO
	speed = 0.0
	await get_tree().create_timer(1.0).timeout
	speed = START_SPEED
	start_random_movement()
	is_resetting = false

func start_random_movement():
	var random_x = -1.0 if randf() < 0.5 else 1.0
	var random_y = randf_range(-0.5, 0.5)
	direction = Vector2(random_x, random_y).normalized()
