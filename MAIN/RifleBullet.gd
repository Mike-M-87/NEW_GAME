extends RigidBody2D


var explosion = preload("res://MAIN/BulletExplosion.tscn")

func _ready():
	if $"../Drone/Sprite".scale.x > 0:
		$Sprite.flip_v = true
	else:
		$Sprite.flip_v = false
	yield(get_tree().create_timer(3),"timeout")
	explode()
	
func _on_RifleBullet_body_entered(body):
	explode()

func explode():
	var explosion_instance = explosion.instance()
	explosion_instance.position = get_global_position()
	get_parent().add_child(explosion_instance)
	queue_free()
