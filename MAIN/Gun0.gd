extends Node2D

#bullets_data [
#	[total , default , bullets]
#	]

export var gun_held: int
export var weapon_pos = Vector2()
export var bullet: PackedScene
export var fire_rate: float
export var bullet_speed: int

var can_fire = true
var rotation_deg_value = 0
var rotation_value = 0
var bullet_motion = Vector2()

onready var LeftHand = get_parent()
onready var world = get_parent().get_parent().get_parent().get_parent()
onready var buttons_timer = get_parent().get_node("buttons_timer")

func _ready():
	check_remaining_bullets()
	update_bullet_labels()
	
func _process(delta):
	if LeftHand.shoot_value > 9 or LeftHand.shoot_value < -9:
		if can_fire and DATA.bullets_data[gun_held][2] > 0:
			var bullet_instance = bullet.instance()
			bullet_instance.position = $BulletPoint.global_position
			bullet_instance.rotation_degrees = rotation_deg_value
			bullet_instance.apply_impulse(Vector2(0,0),bullet_motion.rotated(rotation_value))
			world.add_child(bullet_instance)
			DATA.bullets_data[gun_held][2] -= 1
			update_bullet_labels()
			check_remaining_bullets()
			can_fire = false
			$AudioStreamPlayer.playing = true
			yield(get_tree().create_timer(fire_rate),"timeout")
			can_fire = true

func check_remaining_bullets():
	if DATA.bullets_data[gun_held][2] == 0 and DATA.bullets_data[gun_held][0] > 0:
		reload_gun()
	else:
		pass

func _on_reload_pressed():
	if DATA.bullets_data[gun_held][2] < DATA.bullets_data[gun_held][1]  and DATA.bullets_data[gun_held][0] > 0:
		$ReloadButton/AnimationPlayer.play("reloading")
		buttons_timer.start(0.5)
		yield(LeftHand.get_node("buttons_timer"),"timeout")
		buttons_timer.stop()

		var added_bullets = DATA.bullets_data[gun_held][1] - DATA.bullets_data[gun_held][2]
		
		if DATA.bullets_data[gun_held][0] < added_bullets:
			DATA.bullets_data[gun_held][2] += DATA.bullets_data[gun_held][0]
			DATA.bullets_data[gun_held][0] -= DATA.bullets_data[gun_held][0]
		else:
			DATA.bullets_data[gun_held][2] = DATA.bullets_data[gun_held][1]
			DATA.bullets_data[gun_held][0] -= added_bullets
	update_bullet_labels()


func reload_gun():
	$ReloadButton/AnimationPlayer.play("reloading")
	yield(get_tree().create_timer(1),"timeout")
	if DATA.bullets_data[gun_held][0] < DATA.bullets_data[gun_held][1]:
		DATA.bullets_data[gun_held][2] = DATA.bullets_data[gun_held][0]
		DATA.bullets_data[gun_held][0] -= DATA.bullets_data[gun_held][0]
	else:
		DATA.bullets_data[gun_held][2] = DATA.bullets_data[gun_held][1]
		DATA.bullets_data[gun_held][0] -= DATA.bullets_data[gun_held][1]
	update_bullet_labels()


func update_bullet_labels():
	$ReloadButton/Node2D/bulletsLabel.text = str(DATA.bullets_data[gun_held][2])
	$ReloadButton/Node2D/magazineLabel.text = str("/",DATA.bullets_data[gun_held][0])
