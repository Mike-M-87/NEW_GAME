extends Node2D

onready var aim_joystick = get_parent().get_parent().get_node("CanvasLayer/aim_joystick")
onready var joystick = get_parent().get_parent().get_node("CanvasLayer/move_joystick")
onready var offset_wheel = $front2
onready var sprite = $body/Sprite
onready var world = get_parent().get_parent()

onready var bulletpoint = $body/Sprite/BulletPoint

var direction = 1
var bullet = preload("res://MAIN/TankBullet.tscn")
var bullet_speed = 3000
var can_fire = true
var shoot_value = 0

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
	if world.vehicle == self:
		shoot_value = aim_joystick.get_shoot_value()/10
		
		if shoot_value > 9 or shoot_value < -9:
			if can_fire:
				var bullet_instance = bullet.instance()
				bullet_instance.position = bulletpoint.global_position
				bullet_instance.rotation_degrees = bulletpoint.rotation_degrees
				bullet_instance.apply_impulse(Vector2(0,0),Vector2(bullet_speed*direction,0).rotated(bulletpoint.rotation))
				world.add_child(bullet_instance)
				can_fire = false
				$Reload/AnimationPlayer.play("reload")
				$AudioStreamPlayer.playing = true
				yield(get_tree().create_timer(5),"timeout")
				can_fire = true
	
	if $mid.angular_velocity < -0.1 or $mid.angular_velocity > 0.1:
		rotate_wheels_and_chains()
	
func _physics_process(delta):

	if joystick.get_value().x > 0:
		move_right()
	elif joystick.get_value().x < 0:
		move_left()
		
	if aim_joystick.get_value().x > 0:
		$body/Sprite.scale.x = 0.7
		direction = 1
	elif aim_joystick.get_value().x < 0:
		$body/Sprite.scale.x = -0.7
		direction = -1
		
func parking_mode():
	set_physics_process(false)
	$Reload/ReloadBar.hide()
	set_cam_off()

func entered_mode():
	set_physics_process(true)
	$Reload/ReloadBar.show()
	set_cam_on()

func move_right():
	$front.angular_velocity = min($front.angular_velocity+2,30)
	$rear.angular_velocity = min($rear.angular_velocity+2,30)
	$front2.angular_velocity =min($front2.angular_velocity+2,30)
	$rear2.angular_velocity = min($rear2.angular_velocity+2,30)
	$mid.angular_velocity = min($mid.angular_velocity+2,30)
	offset_wheel = $front2


func move_left():
	$front.angular_velocity = max($front.angular_velocity-2,-30)
	$rear.angular_velocity = max($rear.angular_velocity-2,-30)
	$front2.angular_velocity =max($front2.angular_velocity-2,-30)
	$rear2.angular_velocity = max($rear2.angular_velocity-2,-30)
	$mid.angular_velocity = max($mid.angular_velocity-2,-30)
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
	


func  set_cam_on():
	$body/RemoteTransform2D.remote_path = "../../../../Camera2D"
func set_cam_off():
	$body/RemoteTransform2D.remote_path = ""
