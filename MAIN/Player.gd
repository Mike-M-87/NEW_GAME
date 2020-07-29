extends KinematicBody2D


var UP = Vector2(0,-1)
var jump_height = -700
var acceleration = 1000
var motion = Vector2.ZERO
var max_speed = 500
var gravity = 30
var velocity = Vector2.ZERO
var friction = 1000

onready var joystick = get_parent().get_node("CanvasLayer/move_joystick")
var joystick_value
onready var body = $BodyRig
var vehicle
		
func _physics_process(delta):
	#player_movement()
	move(delta)
	
func _on_VehicleDetector_area_entered(area):
	if area.get_parent().is_in_group("helicopter"):
		get_parent().get_node("CanvasLayer/change_vehicle/Sprite").texture = preload("res://MAIN/sprites/helicopters/helicopter1.png")
		get_parent().get_node("CanvasLayer/change_vehicle/Sprite").scale = Vector2(0.12,0.2)
	elif area.get_parent().get_parent().is_in_group("tank"):
		get_parent().get_node("CanvasLayer/change_vehicle/Sprite").texture = preload("res://MAIN/sprites/tank/tank1.png")
		get_parent().get_node("CanvasLayer/change_vehicle/Sprite").scale = Vector2(0.07,0.09)

	if area.get_parent().is_in_group("vehicle"):
		Signals.emit_signal("vehicle_detected")
		if area.get_parent().get_parent().is_in_group("tank"):
			get_parent().vehicle_detected = area.get_parent().get_parent()
		elif area.get_parent().is_in_group("helicopter"):
			get_parent().vehicle_detected = area.get_parent()
			
		

func _on_VehicleDetector_area_exited(area):
	if area.get_parent().is_in_group("vehicle"):
		Signals.emit_signal("vehicle_undetected")

func move(delta):
	if joystick.get_value().x < 0:
		motion.x = -1
		body.scale.x = -1
	elif joystick.get_value().x > 0:
		motion.x = 1
		body.scale.x = 1
	elif joystick.get_value().x == 0:
		motion.x = 0

	if joystick.get_value() != Vector2.ZERO:
		velocity = velocity.move_toward(motion * max_speed,acceleration * delta) 
	else:
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
	
	if is_on_floor() and joystick.get_value().y * 10 < -4:
		velocity.y = jump_height

	velocity.y += gravity
	velocity = move_and_slide(velocity,UP)
	

func player_movement():
	
	var friction = false
	joystick_value = joystick.get_value() * 10

	velocity.y += gravity

	if joystick_value.x == 0:
		$AnimationPlayer.play("Idle")
		velocity.x = 0
		friction = true
	else:
		$AnimationPlayer.stop()
		pass
	if (joystick_value.x * 10) < 0:
		velocity.x = max(velocity.x - acceleration,-max_speed)
		body.scale.x = -1
		
	elif (joystick_value.x * 10) > 0:
		body.scale.x = 1
		velocity.x = min(velocity.x + acceleration,max_speed)
	
	if is_on_floor():
		if joystick_value.y < -4:
			velocity.y = jump_height
		if friction == true:
			velocity.x = lerp(velocity.x ,0, 0.2)
	else:
		if friction == true:
			velocity.x = lerp(velocity.x ,0,0.05)

	velocity = move_and_slide(velocity,UP)
