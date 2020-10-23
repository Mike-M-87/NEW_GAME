extends Node

var explosion = preload("res://Explosion.tscn")
var bullet_catridge = preload("res://bullet_catridge.tscn")

func bullet_explosion_screenshake(bullet_node,world, amp):
	yield(get_tree(),"idle_frame")
	var length_diff = (bullet_node.global_position-DATA.ready_data.player_pos).length()
	if length_diff < 2000:
		world.screenshake.start(1,(1/length_diff)*amp,(1/length_diff)*(amp-2500))
	bullet_node.queue_free()

func big_explode(bullet_node, world, shake_amp=10000):
	var explosion_instance = explosion.instance()
	explosion_instance.position = bullet_node.get_global_position()
	world.add_child(explosion_instance)
	explosion_instance.get_node("AnimationPlayer").play("Explode")
	Events.bullet_explosion_screenshake(bullet_node,world,shake_amp)


	
func ready_weapon(gun_node):

	if gun_node.get_parent().name == "LeftHand":
		gun_node.set_physics_process(true)
		gun_node.set_process(true)
		gun_node.get_node("ReloadButton/Node2D").show()
		gun_node.mode = RigidBody2D.MODE_STATIC
		gun_node.rotation_degrees = 0
		gun_node.detectable(false)
		gun_node.get_node("AimLine").show()
		gun_node.get_parent().world.set_aimline()
		#get_node("/root/World").set_aimline()
		
		
	elif gun_node.get_parent().name == "Guns":
		#gun_node.set_physics_process(false)
		gun_node.set_process(false)
		gun_node.get_node("ReloadButton/Node2D").hide()
		gun_node.mode = RigidBody2D.MODE_RIGID
		gun_node.detectable(true)
		gun_node.get_node("AimLine").hide()

		
	elif gun_node.get_parent().name == "GunStorage":
		#gun_node.set_physics_process(false)
		gun_node.set_process(false)
		gun_node.get_node("ReloadButton/Node2D").hide()
		gun_node.mode = RigidBody2D.MODE_STATIC
		gun_node.detectable(false)
		gun_node.get_node("AimLine").hide()

func reload_gun(gun_node):
	gun_node.get_node("ReloadButton/AnimationPlayer").play("reloading")
	yield(gun_node.get_node("ReloadButton/AnimationPlayer"),"animation_finished")
	if gun_node.bullets[0] < gun_node.bullets[1]:
		gun_node.bullets[2] = gun_node.bullets[0]
		gun_node.bullets[0] -= gun_node.bullets[0]
	else:
		gun_node.bullets[2] = gun_node.bullets[1]
		gun_node.bullets[0] -= gun_node.bullets[1]
	gun_node.update_bullet_labels()
	gun_node.get_node("ReloadButton/Node2D/reload").hide()

func reload_pressed(gun_node):
	if gun_node.bullets[2] < gun_node.bullets[1]  and gun_node.bullets[0] > 0:
		gun_node.get_node("ReloadButton/AnimationPlayer").play("reloading")
		yield(gun_node.get_node("ReloadButton/AnimationPlayer"),"animation_finished")
		var added_bullets = gun_node.bullets[1] - gun_node.bullets[2]
		if gun_node.bullets[0] < added_bullets:
			gun_node.bullets[2] += gun_node.bullets[0]
			gun_node.bullets[0] -= gun_node.bullets[0]
		else:
			gun_node.bullets[2] = gun_node.bullets[1]
			gun_node.bullets[0] -= added_bullets
	gun_node.update_bullet_labels()
	gun_node.get_node("ReloadButton/Node2D/reload").hide()

func ammo_reload(gun_node,new_gun_node):
	if new_gun_node.bullets[0] > 0 or new_gun_node.bullets[2] > 0:
		var new_total_bullets = new_gun_node.bullets[0] + new_gun_node.bullets[2]
		new_gun_node.queue_free()
		gun_node._on_reload_pressed()
		yield(get_tree().create_timer(1.1),"timeout")
		while gun_node.bullets[0] < gun_node.bullets[3] and new_total_bullets > 0:
			gun_node.bullets[0] += 1
			new_total_bullets -= 1
	gun_node.update_bullet_labels()
	gun_node.check_remaining_bullets()

func eject_bullet_catridge(gun_node):
	var bullet_cat = bullet_catridge.instance()
	bullet_cat.position = gun_node.get_node("catridge_point").global_position
	bullet_cat.rotation_degrees = gun_node.get_parent().rotation_deg_value
	bullet_cat.apply_impulse(Vector2(0,0),Vector2(-gun_node.get_node("../").body.scale.x*100,-100).rotated(gun_node.get_parent().rotation_value))
	gun_node.get_node("../../../../").add_child(bullet_cat)
	if gun_node.name == "Tank":
		bullet_cat.get_node("Sprite").scale = Vector2(1,1)
