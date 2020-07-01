extends Node2D



var bullet = preload("res://MAIN/PlasmaBullet.tscn")
var can_fire = true
var fire_rate = 0.1
var bullet_speed = 1500
onready var LeftHand = get_parent()
var rotation_deg_value = 0
var rotation_value = 0
var bullet_motion = Vector2()
onready var world = get_parent().get_parent().get_parent().get_parent()

func _process(delta):
	if LeftHand.joystick_value.x > 1 or LeftHand.joystick_value.x < -1:
		if can_fire:
			var bullet_instance = bullet.instance()
			bullet_instance.position = $BulletPoint.global_position
			bullet_instance.rotation_degrees = rotation_deg_value
			bullet_instance.apply_impulse(Vector2(0,0),bullet_motion.rotated(rotation_value))
			world.add_child(bullet_instance)
			can_fire = false
			$AudioStreamPlayer.playing = true
			yield(get_tree().create_timer(fire_rate),"timeout")
			can_fire = true
			


