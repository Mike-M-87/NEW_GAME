extends Node2D


var bullet = preload("res://MAIN/RifleBullet.tscn")
var can_fire = true
var fire_rate = 0.1
var bullet_speed = 1500
onready var LeftHand = get_parent()
var rotation_deg_value = 0
var rotation_value = 0
var bullet_motion = Vector2()
onready var world = get_parent().get_parent().get_parent().get_parent()
var def_bullets = 20
onready var buttons_timer = get_parent().get_node("buttons_timer")

func _ready():
	update_bullet_labels()	


func _process(delta):
	if LeftHand.joystick_value.x > 1 or LeftHand.joystick_value.x < -1:
		if can_fire and DATA.ready_data.gun2_bullets > 0:
			var bullet_instance = bullet.instance()
			bullet_instance.position = $BulletPoint.global_position
			bullet_instance.rotation_degrees = rotation_deg_value
			bullet_instance.apply_impulse(Vector2(0,0),bullet_motion.rotated(rotation_value))
			world.add_child(bullet_instance)
			can_fire = false
			DATA.ready_data.gun2_bullets -= 1
			check_remaining_bullets()
			update_bullet_labels()
			$AudioStreamPlayer.playing = true
			yield(get_tree().create_timer(fire_rate),"timeout")
			can_fire = true

func check_remaining_bullets():
	if DATA.ready_data.gun2_bullets == 0 and DATA.ready_data.gun2_tot_bullets > 0:
		reload_gun()
	else:
		pass

func reload_gun():
	$ReloadButton/AnimationPlayer.play("reloading")
	yield(get_tree().create_timer(1),"timeout")
	
	if DATA.ready_data.gun2_tot_bullets < def_bullets:
		DATA.ready_data.gun2_bullets += DATA.ready_data.gun2_tot_bullets
		DATA.ready_data.gun2_tot_bullets -= DATA.ready_data.gun2_tot_bullets
	else:
		DATA.ready_data.gun2_bullets = def_bullets
		DATA.ready_data.gun2_tot_bullets -= def_bullets
	update_bullet_labels()

func _on_reload_pressed():
	buttons_timer.start(0.5)
	yield(LeftHand.get_node("buttons_timer"),"timeout")
	buttons_timer.stop()
	
	if DATA.ready_data.gun2_bullets < 20  and DATA.ready_data.gun2_tot_bullets > 0:
		$ReloadButton/AnimationPlayer.play("reloading")
		yield(get_tree().create_timer(0.5),"timeout")
		
		var added_bullets = def_bullets - DATA.ready_data.gun2_bullets
		if DATA.ready_data.gun2_tot_bullets < added_bullets:
			DATA.ready_data.gun2_bullets += DATA.ready_data.gun2_tot_bullets
			DATA.ready_data.gun2_tot_bullets -= DATA.ready_data.gun2_tot_bullets
		else:
			DATA.ready_data.gun2_bullets = def_bullets
			DATA.ready_data.gun2_tot_bullets -= added_bullets
	update_bullet_labels()

func update_bullet_labels():
	$ReloadButton/Node2D/bulletsLabel.text = str(DATA.ready_data.gun2_bullets)
	$ReloadButton/Node2D/magazineLabel.text = str("/",DATA.ready_data.gun2_tot_bullets)












