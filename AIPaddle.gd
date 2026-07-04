extends CharacterBody2D
@export var SPEED: float = 500.0#export olayı inspectordan veri girmemizi sağlıyor
@export var ball: CharacterBody2D

var min_y: float = -260.0#max ve min gidebileceği değerler
var max_y: float = 260.0

func _physics_process(delta):
	if ball == null or not is_instance_valid(ball):#birisi sayı yapıp top silindiğinde bu kodun çökmemesini sağlar
		return

	var target_y = clamp(ball.global_position.y + ball.velocity.y * 0.25, min_y, max_y)#burdaki mantık topun 0.5 saniye sonra nereye gideceğini hesaplıyoruz
	global_position.y = move_toward(global_position.y, target_y, SPEED * delta)#target y ye doğru raketi kaydırır fakat bunu move_toward ile pürüssüz yapar
	global_position.y = clamp(global_position.y, min_y, max_y)#clamp fonksiyonu da bu tahmini hedefin belirlenen sınırların (-260 ile 270) dışına taşmamasını sağlıyor.

#clamp(value, min, max)
#move_toward(from, to, delta) hedefe sabit bir hızla gider bundan dolayı titreme yapmaz
#is_instance_valid(instance) Hafızada bir nesnenin (Node, CharacterBody, Enemy vb.) hâlâ canlı ve geçerli olup olmadığını kontrol eder.
