extends CharacterBody2D

# Raketin ilk/taban hızı (Top uzaktayken bu hızda çalışır)
var base_speed: float = 400.0
var ball: CharacterBody2D

func _ready() -> void:
	ball = get_parent().get_node("Ball")

func _physics_process(delta: float) -> void:
	if ball:
		# 1. Geleceği tahmin eden o asil Y pozisyonu hesaplamamız:
		var next_ball_pos_y = ball.global_position.y + (ball.direction.y * ball.speed * delta)
		
		# 🎯 2. TOP YAKLAŞTIKÇA HIZLANMA MANTIĞI:
		# Top ile raket arasındaki yatay (X eksenindeki) mesafeyi buluyoruz.
		var distance_x = abs(ball.global_position.x - global_position.x)
		
		# Mesafe azaldıkça (top yaklaştıkça) hızı dinamik olarak arttıran basit matematik:
		# Top en dibimize geldiğinde hızı otomatik olarak 400'den ~750'ye kadar fırlatır!
		var dynamic_speed = base_speed + (20000.0 / (distance_x + 50.0))
		
		# 3. Raketi bu dinamik hıza göre yönlendiriyoruz:
		if next_ball_pos_y < global_position.y:
			velocity.y = -dynamic_speed
		elif next_ball_pos_y > global_position.y:
			velocity.y = dynamic_speed
		else:
			velocity.y = 0
			
	move_and_slide()
