extends RigidBody2D


var can_see_player = false


func _on_PlayerDetector_body_entered(body):
	if body.is_in_group("player") or body.is_in_group("vehicle"):
		can_see_player = true

func _on_PlayerDetector_body_exited(body):
	if body.is_in_group("player") or body.is_in_group("vehicle"):
		can_see_player = false


func change_weapon():
	if DATA.change_gun_range < DATA.total_guns-1:
		DATA.change_gun_range += 1
	else:
		DATA.change_gun_range = 0
	while DATA.change_gun_range < DATA.total_guns:
		if check_gun_avail(DATA.change_gun_range) == true:
			break
		else:
			if DATA.change_gun_range < DATA.total_guns-1:
				DATA.change_gun_range += 1
			else:
				DATA.change_gun_range = 0
	if DATA.change_gun_range > 3:
		DATA.ready_data.weapon = "res://MAIN/RPG"+str(DATA.change_gun_range-4)+".tscn"
	else:
		DATA.ready_data.weapon = "res://MAIN/Pistol"+str(DATA.change_gun_range)+".tscn"
func check_gun_avail(value):
	if DATA.Guns_avail[value] == true:
		return true
	else:
		return false


func _on_hurtbox_body_entered(body):
	if body.is_in_group("playerbullet"):
		queue_free()
