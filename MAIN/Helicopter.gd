extends RigidBody2D


onready var move_joystick = get_parent().get_parent().get_node("CanvasLayer/move_joystick")

var accel = 30
var wintermap = preload("res://MAIN/WinterBackground.tscn")
var bullet = preload("res://MAIN/HeliBullet.tscn")
var can_fire = true
var fire_rate = 0.1
var bullet_speed = 1500
var can_start_fire = false
var bullet_motion = Vector2(-bullet_speed,0)
onready var world = get_parent().get_parent()
onready var sprite = $Sprite
onready var camera = $Camera2D
onready var remote_transform = $RemoteTransform2D

func _ready():
	parking_mode()
	
func _physics_process(delta):

	if move_joystick.get_value().x < 0:
		$Sprite.flip_h = false
		linear_velocity.x = max(linear_velocity.x-accel,-700)
	
	elif move_joystick.get_value().x > 0:
		$Sprite.flip_h = true
		linear_velocity.x = min(linear_velocity.x+accel,700)
	
	else:
		linear_velocity = linear_velocity.move_toward(Vector2(0,0),10)
	
	if  move_joystick.get_value().y > 0:
		linear_velocity.y = min(linear_velocity.y+accel,300) 

	elif move_joystick.get_value().y < -0:
		linear_velocity.y = max(linear_velocity.y-accel,-300)
	
	else:
		linear_velocity = linear_velocity.move_toward(Vector2(0,0),10)
	rotation_degrees = move_joystick.get_value().x * 10
	print(move_joystick.get_value())


		
		
	
func _process(delta):
	if can_fire and can_start_fire:
		var bullet_instance = bullet.instance()
		bullet_instance.position = $Sprite/BulletPoint.global_position
		bullet_instance.rotation_degrees = rotation_degrees
		bullet_instance.apply_impulse(Vector2(0,0),bullet_motion.rotated(rotation))
		world.add_child(bullet_instance)
		can_fire = false
		$AudioStreamPlayer.playing = true
		yield(get_tree().create_timer(fire_rate),"timeout")
		can_fire = true
		
func _on_TouchScreenButton_pressed():
	if can_start_fire == false:
		can_start_fire = true
	elif can_start_fire == true:
		can_start_fire = false

func parking_mode():
	set_physics_process(false)
	set_process(false)
	$CanvasLayer/TouchScreenButton.hide()
	set_cam_off()

func entered_mode():
	set_process(true)
	set_physics_process(true)
	$CanvasLayer/TouchScreenButton.show()
	set_cam_on()
	
	
func  set_cam_on():
	remote_transform.remote_path = "../../../Camera2D"	
func set_cam_off():
	remote_transform.remote_path = ""

