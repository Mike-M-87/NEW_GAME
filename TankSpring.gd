extends Node2D


func _input(event):
	if event.is_action("ui_right"):
		get_node("wheel").set_angular_velocity(20)
		get_node("wheel2").set_angular_velocity(20)
	if event.is_action("ui_left"):
		get_node("wheel").set_angular_velocity(-20)
		get_node("wheel2").set_angular_velocity(-20)
