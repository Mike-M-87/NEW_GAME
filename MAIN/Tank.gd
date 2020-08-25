extends Node2D

onready var aim_joystick = get_parent().get_parent().get_node("CanvasLayer/aim_joystick")
onready var joystick = get_parent().get_parent().get_node("CanvasLayer/move_joystick")
onready var offset_wheel = $front2
onready var camera= $body/Camera2D
onready var sprite = $body/Sprite

#var bullet = preload("res://MAIN/RifleBullet.tscn")
onready var world = get_parent().get_parent()
onready var remote_transform =  $body/RemoteTransform2D
var bullet_speed = 1500
var can_fire = true


func _ready():
	parking_mode()
	hide_wheels()
	
func hide_wheels():
	$front.hide()
	$rear.hide()
	$front2.hide()
	$rear2.hide()
	$mid.hide()

func _process(delta):
	if $mid.angular_velocity < -0.1 or $mid.angular_velocity > 0.1:
		rotate_wheels_and_chains()
func _physics_process(delta):

	if joystick.get_value().x > 0:
		move_right()
	elif joystick.get_value().x < 0:
		move_left()
	
func parking_mode():
	set_physics_process(false)
	#$body/Camera2D.current = false
	remote_transform.remote_path = ""

func entered_mode():
	#$body/Camera2D.current = true
	set_physics_process(true)
	remote_transform.remote_path = "../../../../Camera2D"


func move_right():
	$front.angular_velocity = min($front.angular_velocity+2,30)
	$rear.angular_velocity = min($rear.angular_velocity+2,30)
	$front2.angular_velocity =min($front2.angular_velocity+2,30)
	$rear2.angular_velocity = min($rear2.angular_velocity+2,30)
	$mid.angular_velocity = min($mid.angular_velocity+2,30)
	$body/Sprite.flip_h = false
	offset_wheel = $front2

func move_left():
	$front.angular_velocity = max($front.angular_velocity-2,-30)
	$rear.angular_velocity = max($rear.angular_velocity-2,-30)
	$front2.angular_velocity =max($front2.angular_velocity-2,-30)
	$rear2.angular_velocity = max($rear2.angular_velocity-2,-30)
	$mid.angular_velocity = max($mid.angular_velocity-2,-30)
	$body/Sprite.flip_h = true
	offset_wheel = $rear2
	
func rotate_wheels_and_chains():
	$body/Path2D/PathFollow2D.offset += offset_wheel.angular_velocity /3
	$body/Path2D/PathFollow2D2.offset += offset_wheel.angular_velocity/3
	$body/Path2D/PathFollow2D3.offset += offset_wheel.angular_velocity/3
	$body/Path2D/PathFollow2D4.offset += offset_wheel.angular_velocity/3
	$body/Path2D/PathFollow2D5.offset += offset_wheel.angular_velocity/3
	$body/Path2D/PathFollow2D6.offset += offset_wheel.angular_velocity/3
	$body/Path2D/PathFollow2D7.offset += offset_wheel.angular_velocity/3
	$body/Path2D/PathFollow2D8.offset += offset_wheel.angular_velocity/3
	$body/Path2D/PathFollow2D9.offset += offset_wheel.angular_velocity/3
	$body/Path2D/PathFollow2D10.offset += offset_wheel.angular_velocity/3
	$body/Path2D/PathFollow2D11.offset += offset_wheel.angular_velocity/3
	$body/Path2D/PathFollow2D12.offset += offset_wheel.angular_velocity/3
	$body/Path2D/PathFollow2D13.offset += offset_wheel.angular_velocity/3
	$body/Path2D/PathFollow2D14.offset += offset_wheel.angular_velocity/3
	$body/Path2D/PathFollow2D15.offset += offset_wheel.angular_velocity/3
	$body/Path2D/PathFollow2D16.offset += offset_wheel.angular_velocity/3
	$body/Path2D/PathFollow2D17.offset += offset_wheel.angular_velocity/3
	$body/Path2D/PathFollow2D18.offset += offset_wheel.angular_velocity/3
	$body/Path2D/PathFollow2D19.offset += offset_wheel.angular_velocity/3
	$body/Path2D/PathFollow2D20.offset += offset_wheel.angular_velocity/3
	$body/Path2D/PathFollow2D21.offset += offset_wheel.angular_velocity/3
	$body/Path2D/PathFollow2D22.offset += offset_wheel.angular_velocity/3
	$body/Path2D/PathFollow2D23.offset += offset_wheel.angular_velocity/3
	$body/Path2D/PathFollow2D24.offset += offset_wheel.angular_velocity/3
	$body/Path2D/PathFollow2D25.offset += offset_wheel.angular_velocity/3
	$body/Path2D/PathFollow2D26.offset += offset_wheel.angular_velocity/3
	$body/Path2D/PathFollow2D27.offset += offset_wheel.angular_velocity/3
	$body/Path2D/PathFollow2D28.offset += offset_wheel.angular_velocity/3
	$body/Path2D/PathFollow2D29.offset += offset_wheel.angular_velocity/3
	$body/Path2D/PathFollow2D30.offset += offset_wheel.angular_velocity/3
	$body/Path2D/PathFollow2D31.offset += offset_wheel.angular_velocity/3

	
	
	$body/ChainHold/wheel1.rotation_degrees = $body/Path2D/PathFollow2D.offset
	$body/ChainHold/wheel2.rotation_degrees= $body/Path2D/PathFollow2D.offset
	$body/ChainHold/wheel3.rotation_degrees = $body/Path2D/PathFollow2D.offset
	$body/ChainHold/wheel4.rotation_degrees= $body/Path2D/PathFollow2D.offset
	$body/ChainHold/wheel5.rotation_degrees = $body/Path2D/PathFollow2D.offset
	$body/ChainHold/wheel6.rotation_degrees = $body/Path2D/PathFollow2D.offset
	$body/ChainHold/chainwheel.rotation_degrees = $body/Path2D/PathFollow2D.offset
	$body/ChainHold/chainwheel2.rotation_degrees = $body/Path2D/PathFollow2D.offset
	




