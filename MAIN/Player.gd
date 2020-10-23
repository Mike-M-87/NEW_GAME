extends KinematicBody2D


var UP = Vector2(0,-1)
var jump_height = -1000
var acceleration = 1000
var motion = Vector2.ZERO
var max_speed = 500
var gravity = 30

var velocity = Vector2.ZERO
var friction = 1000
onready var joystick = get_parent().get_node("CanvasLayer/move_joystick")
onready var body = $BodyRig
var anim
enum{
	gunshot
}

func _process(delta):
	
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

	elif joystick.get_value().x > 0:
		motion.x = 1

	elif joystick.get_value().x == 0:
		motion.x = 0

	if joystick.get_value() != Vector2.ZERO:

		velocity = velocity.move_toward(motion * max_speed,acceleration * delta) 
	else:
		#$AnimationPlayer.play("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
	
	if is_on_floor() and joystick.get_value().y * 10 < -4:
		velocity.y = jump_height
	
	velocity.y += gravity
	set_movement()
	
func set_movement():
	velocity = move_and_slide(velocity,UP)
	$AnimationPlayer.playback_speed




func in_vehicle():
	set_physics_process(false)
	$BodyRig/LeftHand.set_process(false)
	$BodyRig/LeftHand.set_process(false)
	set_process(false)
	set_cam_off()
	
func off_vehicle():
	set_physics_process(true)
	$BodyRig/LeftHand.set_process(true)
	$BodyRig/LeftHand.set_process(true)
	set_process(true)
	set_cam_on()
	
func  set_cam_on():
	$RemoteTransform2D.remote_path = "../../Camera2D"
func set_cam_off():
	$RemoteTransform2D.remote_path = ""
