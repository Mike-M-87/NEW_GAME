extends KinematicBody2D


var UP = Vector2(0,-1)
var jump_height = -700
var acceleration = 1000
var motion = Vector2.ZERO
var max_speed = 500
var gravity = 30
var velocity = Vector2.ZERO
var friction = 1000
onready var gun_hand = $BodyRig/LeftHand


onready var joystick = get_parent().get_node("CanvasLayer/move_joystick")
var joystick_value
onready var body = $BodyRig
var vehicle
var number = 0
onready var camera = $Camera2D

func _ready():
	$RemoteTransform2D.remote_path = "../../Camera2D"
	pass
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
		flip_dir("left")
	elif joystick.get_value().x > 0:
		motion.x = 1
		flip_dir("right")
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
	velocity = move_and_slide(velocity,UP)

func _on_GunDetector_area_entered(area):
	if area.get_parent().is_in_group("pickableGun"):
		get_parent().gun_detected = area.get_parent()
		Signals.emit_signal("gun_detected")

func _on_GunDetector_area_exited(area):
	if area.get_parent().is_in_group("pickableGun"):
		Signals.emit_signal("gun_undetected")

func flip_dir(dir):
	
	var flipspeed = 0.45
	if dir == "right":
		body.scale.x = min(body.scale.x+flipspeed,1)
	else:
		body.scale.x = max(body.scale.x-flipspeed,-1)
