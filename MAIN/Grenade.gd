extends KinematicBody2D

var explosion = preload("res://MAIN/BulletExplosion.tscn")

func _ready():
	$explodeTimer.start(5)
	yield($explodeTimer,"timeout")
	$explodeTimer.stop()
	explode()

func explode():
	var explosion_instance = explosion.instance()
	explosion_instance.position = get_global_position()
	explosion_instance.scale = Vector2(3,3)
	get_parent().add_child(explosion_instance)
	queue_free()


