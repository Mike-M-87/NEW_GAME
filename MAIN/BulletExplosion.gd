extends AnimatedSprite

func _ready():
	play("explode")
func _on_BulletExplosion_animation_finished():
	queue_free()
