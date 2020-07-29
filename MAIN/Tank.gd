extends Node2D

onready var world = get_parent()
onready var joystick = get_parent().get_parent().get_node("CanvasLayer/move_joystick")
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
	$body/Path2D/PathFollow2D.offset += $mid.angular_velocity /3
	$body/Path2D/PathFollow2D2.offset += $mid.angular_velocity/3
	$body/Path2D/PathFollow2D3.offset += $mid.angular_velocity/3
	$body/Path2D/PathFollow2D4.offset += $mid.angular_velocity/3
	$body/Path2D/PathFollow2D5.offset += $mid.angular_velocity/3
	$body/Path2D/PathFollow2D6.offset += $mid.angular_velocity/3
	$body/Path2D/PathFollow2D7.offset += $mid.angular_velocity/3
	$body/Path2D/PathFollow2D8.offset += $mid.angular_velocity/3
	$body/Path2D/PathFollow2D9.offset += $mid.angular_velocity/3
	$body/Path2D/PathFollow2D10.offset += $mid.angular_velocity/3
	$body/Path2D/PathFollow2D11.offset += $mid.angular_velocity/3
	$body/Path2D/PathFollow2D12.offset += $mid.angular_velocity/3
	$body/Path2D/PathFollow2D13.offset += $mid.angular_velocity/3
	$body/Path2D/PathFollow2D14.offset += $mid.angular_velocity/3
	$body/Path2D/PathFollow2D15.offset += $mid.angular_velocity/3
	$body/Path2D/PathFollow2D16.offset += $mid.angular_velocity/3
	$body/Path2D/PathFollow2D17.offset += $mid.angular_velocity/3
	$body/Path2D/PathFollow2D18.offset += $mid.angular_velocity/3
	$body/Path2D/PathFollow2D19.offset += $mid.angular_velocity/3
	$body/Path2D/PathFollow2D20.offset += $mid.angular_velocity/3
	$body/Path2D/PathFollow2D21.offset += $mid.angular_velocity/3
	$body/Path2D/PathFollow2D22.offset += $mid.angular_velocity/3
	$body/Path2D/PathFollow2D23.offset += $mid.angular_velocity/3
	$body/Path2D/PathFollow2D24.offset += $mid.angular_velocity/3
	$body/Path2D/PathFollow2D25.offset += $mid.angular_velocity/3
	$body/Path2D/PathFollow2D26.offset += $mid.angular_velocity/3
	$body/Path2D/PathFollow2D27.offset += $mid.angular_velocity/3
	
	
	$body/Sprite2/wheel.rotation_degrees = $body/Path2D/PathFollow2D.offset
	$body/Sprite2/wheel2.rotation_degrees = $body/Path2D/PathFollow2D.offset
	$body/Sprite2/wheelhold/wheel3.rotation_degrees = $body/Path2D/PathFollow2D.offset
	$body/Sprite2/wheelhold/wheel4.rotation_degrees = $body/Path2D/PathFollow2D.offset
	$body/Sprite2/wheelhold2/wheel3.rotation_degrees = $body/Path2D/PathFollow2D.offset
	$body/Sprite2/wheelhold2/wheel4.rotation_degrees = $body/Path2D/PathFollow2D.offset
	$body/Sprite2/wheelhold3/wheel3.rotation_degrees = $body/Path2D/PathFollow2D.offset
	$body/Sprite2/wheelhold3/wheel4.rotation_degrees = $body/Path2D/PathFollow2D.offset
	
func _physics_process(delta):
	if joystick.get_value().x > 0:
		move_right()
	elif joystick.get_value().x < 0:
		move_left()

func parking_mode():
	#set_process(false)
	set_physics_process(false)
	$CanvasLayer/shootbutton.hide()
	$body/Camera2D.current = false

func entered_mode():
	$CanvasLayer/shootbutton.show()
	$body/Camera2D.current = true
	#set_process(true)
	set_physics_process(true)


func move_right():
	$front.angular_velocity = min($front.angular_velocity+2,30)
	$rear.angular_velocity = min($rear.angular_velocity+2,30)
	$front2.angular_velocity =min($front2.angular_velocity+2,30)
	$rear2.angular_velocity = min($rear2.angular_velocity+2,30)
	$mid.angular_velocity = min($mid.angular_velocity+2,30)
	$body/Sprite.flip_h = false
	print($front.angular_velocity)

func move_left():
	$front.angular_velocity = max($front.angular_velocity-2,-30)
	$rear.angular_velocity = max($rear.angular_velocity-2,-30)
	$front2.angular_velocity =max($front2.angular_velocity-2,-30)
	$rear2.angular_velocity = max($rear2.angular_velocity-2,-30)
	$mid.angular_velocity = max($mid.angular_velocity-2,-30)
	$body/Sprite.flip_h = true
