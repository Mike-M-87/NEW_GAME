extends RigidBody2D

onready var Heli = get_parent().vehicle
var explosion = preload("res://MAIN/BulletExplosion.tscn")

func _ready():
	if Heli.sprite.flip_h == false:
		$Sprite.rotation_degrees = -90
	if Heli.sprite.flip_h == true:
		$Sprite.rotation_degrees = 90
	yield(get_tree().create_timer(3),"timeout")
	explode()
	
func explode():
	var explosion_instance = explosion.instance()
	explosion_instance.position = get_global_position()
	get_parent().add_child(explosion_instance)
	queue_free()


func _on_HeliBullet_body_entered(body):
	explode()
