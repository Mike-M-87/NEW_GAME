extends Node2D

var boundary = 20
onready var button = $Button
var radius = Vector2(54,54)

var ongoing_drag = -1

func get_button_pos():
	return button.position



func _input(event):

	if event is InputEventScreenDrag or (event is InputEventScreenTouch and event.is_pressed()):
		var event_dist_from_centre = (event.position - global_position).length()
		
		if event_dist_from_centre <= boundary * button.global_scale.x * 4 or event.get_index() == ongoing_drag:
			button.global_position = (event.position)
			
			if get_button_pos().length() > boundary * $Radius.global_scale.x:
				button.position = get_button_pos().normalized() * radius * (button.global_scale.x)
	
			ongoing_drag = event.get_index()
	if event is InputEventScreenTouch and !event.is_pressed() and event.get_index() == ongoing_drag:
		ongoing_drag = -1
	$shoot_node.position = button.position

func get_value():
	return get_button_pos().normalized()

func get_shoot_value():
	if ongoing_drag != -1:	
		return ($shoot_node.position-Vector2(0,0)).length()
	else:
		return 0
	

func get_dir():
	if get_value().x > 0:
		return  1
	elif get_value().x < 0:
		return -1
	elif get_value().x == 0:
		return 0



