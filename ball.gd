extends CharacterBody2D

var speed: float = 500.0
var direction: Vector2 = Vector2.ZERO
const START_SPEED: float = 500.0
var is_resetting: bool = false
const MAX_SPEED: float = 1100.0
const max_y_vector : float	= 0.6
func _ready() -> void:
	start_random_movement()
	
func _physics_process(delta):
	if is_resetting:
		return
	
	var collision = move_and_collide(direction * speed * delta)
	if collision:
		var collider = collision.get_collider()
		if collider.name.contains("LeftPlayer") or collider.name.contains("RightPlayer"):
			speed = clamp(speed * 1.05, START_SPEED, MAX_SPEED)
			var relative_intersect = global_position.y - collider.global_position.y #raketin topa göre konumunu ayarlamak için mesafeyi ölçüyoruz
			var normalized_intersect_y = relative_intersect / 64 #mesafeyi raketin uzunluğuna böldüğümüzde eğer ki -1 gelirse yukarıda 0 gelirse ortada +1 gelirse aşağıda olduğunu anlıyoruz
			var x_new_dir = -1 if direction.x > 0 else 1.0 #top x konumuna göre hangi yönde geliyosa tam tersine gönderiyoruz
			direction = Vector2(x_new_dir, normalized_intersect_y).normalized()#topun gidişatını motora söylüyoruz
		else:
			direction = direction.bounce(collision.get_normal())
			
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
