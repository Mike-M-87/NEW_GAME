extends RigidBody2D


onready var Tank = get_parent().vehicle
var explosion = preload("res://MAIN/BulletExplosion.tscn")

func _ready():
	if get_parent().player_form == "tank":
		Tank = get_parent().get_node("Tank")
	elif get_parent().player_form == "tank2":
		Tank = get_parent().get_node("Tank2")
	if Tank.sprite.flip_h == false:
		$Sprite.rotation_degrees = 90
	if Tank.sprite.flip_h == true:
		$Sprite.rotation_degrees = -90
	
	yield(get_tree().create_timer(3),"timeout")
	explode()
	
func explode():
	var explosion_instance = explosion.instance()
	explosion_instance.position = get_global_position()
	explosion_instance.scale = Vector2(3,3)
	get_parent().add_child(explosion_instance)
	queue_free()

func _on_TankBullet_body_entered(body):
	explode()
