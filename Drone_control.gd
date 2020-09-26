extends Node2D

var ongoing_drag = -1

func _ready():
	pass

func get_ball_pos():
	return $ball.position
	
func _input(event):
	if event is InputEventScreenDrag or (event is InputEventScreenTouch and event.is_pressed()):
		var boundary = scale.x * 100
		var event_dist = (event.position - global_position).length()
		
		if event_dist <= boundary*3 or event.get_index() == ongoing_drag:
			$ball.global_position = event.position
		
			if get_ball_pos().length() > boundary:
				$ball.position = get_ball_pos().normalized() * Vector2(boundary,boundary)
			
			ongoing_drag = event.get_index()
			
	if event is InputEventScreenTouch and !event.is_pressed() and event.get_index() == ongoing_drag:
		ongoing_drag = -1

func _process(delta):
	if ongoing_drag == -1:
		$ball.position = $ball.position.move_toward(Vector2(0,0) * 200,10)

func get_value():
	return get_ball_pos().normalized()
	
