extends Node2D

#pistol_bullets_data [
#	[total , default , bullets]
#	]



var bullets = [120,30,30,120]
var gun_name = 3
var weapon_pos = Vector2(50,2)
var fire_rate = 0.1
var bullet_speed = 5000

var bullet = preload("res://MAIN/PlasmaBullet.tscn")
var can_fire = true


func _ready():
	Events.ready_weapon(self)	
	check_remaining_bullets()
	update_bullet_labels()

	
func _process(delta):
	if get_parent().shoot_value > 9 or get_parent().shoot_value < -9:
		if can_fire and bullets[2] > 0:
			var bullet_instance = bullet.instance()
			bullet_instance.position = $BulletPoint.global_position
			bullet_instance.rotation_degrees = get_parent().rotation_deg_value
			bullet_instance.apply_impulse(Vector2(0,0),get_parent().bullet_motion.rotated(get_parent().rotation_value))
			$"../../../../".add_child(bullet_instance)
			bullets[2] -= 1
			update_bullet_labels()
			check_remaining_bullets()
			can_fire = false
			$AudioStreamPlayer.playing = true
			yield(get_tree().create_timer(fire_rate),"timeout")
			can_fire = true

func detectable(n:bool):
	$Detector/CollisionShape2D.disabled = not n

func check_remaining_bullets():
	if bullets[2] == 0 and bullets[0] > 0:
		reload_gun()
	else:
		pass

func _on_reload_pressed():
	Events.reload_pressed(self)
	
func reload_gun():
	Events.reload_gun(self)

func update_bullet_labels():
	$ReloadButton/Node2D/bulletsLabel.text = str(bullets[2])
	$ReloadButton/Node2D/magazineLabel.text = str("/",bullets[0])
