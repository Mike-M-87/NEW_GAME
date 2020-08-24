extends Node2D

var boundary = 20
onready var button = $Button
var radius = Vector2(54,54)
var isTouched = false
var ongoing_drag = -1

func get_button_pos():
	return button.position

func _process(delta):
	if ongoing_drag == -1:
		var center_pos = Vector2(0,0)
		button.position = button.position.move_toward(center_pos * 200,10)
	$shoot_node.position = $Button.position
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

func get_value():
	return get_button_pos().normalized()

func get_shoot_value():
	return ($shoot_node.position-$Radius.position).length()
