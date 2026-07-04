extends Area2D

var speed: float = 400.0
const START_SPEED: float = 400.0
const MAX_SPEED: float = 1000.0
var direction: Vector2 = Vector2.ZERO

var is_resetting: bool = false

func _ready() -> void:
	start_random_movement()

func _process(delta):
	if is_resetting:
		return
	
	# Area2D özgür bir alan olduğu için pozisyonunu doğrudan biz ilerletiyoruz
	global_position += direction * speed * delta

func reset_ball() -> void:
	if is_resetting:
		return
	is_resetting = true
	
	global_position = Vector2(0, 0) # Veya ekranının tam ortası
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


func _on_body_entered(body: Node2D) -> void:
	# 1. RAKETLERE ÇARPTIYSAYSA
	if body.name.contains("LeftPlayer") or body.name.contains("RightPlayer"):
		speed = clamp(speed * 1.05, START_SPEED, MAX_SPEED)
		
		# Harika falso matematiğin
		var relative_intersect_y = global_position.y - body.global_position.y
		var normalized_intersect_y = relative_intersect_y / 60.0
		
		# Sol rakete çarptıysa sağa, sağ rakete çarptıysa sola fırlat
		if body.name.contains("LeftPlayer"):
			direction = Vector2(1.0, normalized_intersect_y).normalized()
		elif body.name.contains("RightPlayer"):
			direction = Vector2(-1.0, normalized_intersect_y).normalized()
			
		print("Raketten Sekti! Yeni Hız: ", speed)

	# 2. DUVARLARA ÇARPTIYSAYSA (Statik gövdelere veya haritaya)
	elif body.name.contains("Wall") or body is StaticBody2D:
		# Üst veya alt duvara çarptığı için sadece Y yönünü tersine çeviriyoruz
		direction.y = -direction.y
		print("Duvardan Sekti!")
