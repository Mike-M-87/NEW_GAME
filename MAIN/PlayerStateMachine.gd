extends Node

enum {
	IDLE,
	RUN,
	SNEAK,
	SHOOT,
	CROUCH,
	CHANGE_GUN,
	VEHICLE,
	KNOCKBACK,
	INJURED,
}
var state = IDLE

func _physics_process(delta):
#	match state:
#		IDLE:
#			idle_state()
#		RUN:
#			run_state()
#		SNEAK:
#			sneak_state()
#		SHOOT:
#			shoot_state()
#		CROUCH:
#			crouch_state()
#		CHANGE_GUN:
#			change_gun()
#		VEHICLE:
#			enter_vehicle(vehicle)
#		KNOCKBACK:
#			knockback()
#		INJURED:
#			injured_state()
	pass
