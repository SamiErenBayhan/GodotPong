extends CharacterBody2D

var speed: float = 400.0
var direction: Vector2 = Vector2.ZERO

func _ready() -> void:
	var random_x = randf_range(-1, 1)
	var random_y = randf_range(-1, 1)#sağ veya sola herhangi bi yöne gitmesi için değer verdiriyoruz
	direction = Vector2(random_x, random_y).normalized()#değer sapıtmasın yanlış hesaplar yapmasın diye bu kodu kullanıyoruz. Godot onu kendi ayarlıyor.

func _physics_process(delta: float) -> void:
	var collision = move_and_collide(direction * speed * delta)
	if collision:
		direction = direction.bounce(collision.get_normal())
