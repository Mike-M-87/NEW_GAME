extends KinematicBody2D


var UP = Vector2(0,-1)
var jump_height = -700
var max_speed = 60
var gravity = 30
var velocity = Vector2()
onready var joystick = get_parent().get_node("CanvasLayer/move_joystick")
var joystick_value
onready var body = $BodyRig
var vehicle

func _physics_process(delta):
	joystick_value = joystick.get_value() * 10
	
	velocity.y += gravity
	velocity.x = (joystick_value.x * max_speed)
	
	if joystick_value.x == 0:
		$AnimationPlayer.play("Idle")
	else:
		$AnimationPlayer.stop()
	if (joystick_value.x * 10) < 0:
		body.scale.x = -1
		
	if (joystick_value.x * 10) > 0:
		body.scale.x = 1
		
	if is_on_floor() and joystick_value.y < -4:
		velocity.y = jump_height

	velocity = move_and_slide(velocity,UP)
	



func _on_VehicleDetector_area_entered(area):
	if area.is_in_group("vehicle"):
		
		Signals.emit_signal("vehicle_detected")
		get_parent().vehicle_detected = area.get_parent()
		

func _on_VehicleDetector_area_exited(area):
	if area.is_in_group("vehicle"):
		Signals.emit_signal("vehicle_undetected")
		
