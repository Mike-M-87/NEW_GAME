extends RigidBody2D


onready var LeftHand = $"../Player/BodyRig/LeftHand"#get_parent().get_node("Player").get_node("BodyRig").get_node("LeftHand")
var explosion = preload("res://MAIN/BulletExplosion.tscn")
export (Color) var explosion_color

func _ready():
	if LeftHand.joystick_value.x < 0:
		$Sprite.rotation_degrees = -90
	elif LeftHand.joystick_value.x > 0:
		$Sprite.rotation_degrees = 90
	yield(get_tree().create_timer(3),"timeout")
	explode()

func _on_PlasmaBullet_body_entered(body):
	explode()

func explode():
	var explosion_instance = explosion.instance()
	explosion_instance.position = get_global_position()
	explosion_instance.modulate = explosion_color
	get_parent().add_child(explosion_instance)
	queue_free()
