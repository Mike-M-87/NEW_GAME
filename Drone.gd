extends RigidBody2D

onready var move_joystick = $CanvasLayer/Drone_control
onready var aim_joystick = get_node("../CanvasLayer/aim_joystick")
onready var world = $"../"

export (Color) var not_selected
export (Color) var selected

var accel = 30
var bullet = preload("res://MAIN/RifleBullet.tscn")
var can_fire = true
var start_fire = false
var Enemy
var pos_diff
var auto_enabled = true

enum {
	Auto,
	remove,
	control
}

var state = control

func _ready():
	set_process(false)
	button_displays()
	
func  set_cam_on():
	$RemoteTransform2D.remote_path = "../../Camera2D"
func set_cam_off():
	$RemoteTransform2D.remote_path = ""

func _physics_process(delta):

	if move_joystick.get_value().x < -0.9:
		$Sprite.scale.x = 0.5
		linear_velocity.x = max(linear_velocity.x-accel,-700)
	
	elif move_joystick.get_value().x > 0.9:
		$Sprite.scale.x = -0.5
		linear_velocity.x = min(linear_velocity.x+accel,700)
	
	else:
		linear_velocity = linear_velocity.move_toward(Vector2(0,0),10)
	
	if  move_joystick.get_value().y > 0.4:
		linear_velocity.y = min(linear_velocity.y+accel,300) 

	elif move_joystick.get_value().y < -0.4:
		linear_velocity.y = max(linear_velocity.y-accel,-300)
	
	else:
		linear_velocity = linear_velocity.move_toward(Vector2(0,0),10)
	rotation_degrees = move_joystick.get_value().x * 10
	
	if state == Auto:
		if can_fire and Enemy != null:
			var bullet_instance = bullet.instance()
			bullet_instance.position = $Sprite/BulletPoint.global_position
			bullet_instance.rotation_degrees = rotation_degrees
			bullet_instance.apply_impulse(Vector2(50,100),Vector2(-5000*$Sprite.scale.x,0).rotated(rotation))
			world.add_child(bullet_instance)
			can_fire = false
			yield(get_tree().create_timer(0.05),"timeout")
			can_fire = true
	
	elif start_fire == true:
		if can_fire:
			var bullet_instance = bullet.instance()
			bullet_instance.position = $Sprite/BulletPoint.global_position
			bullet_instance.rotation_degrees = rotation_degrees
			bullet_instance.apply_impulse(Vector2(50,100),Vector2(-5000*$Sprite.scale.x,0).rotated(rotation))
			world.add_child(bullet_instance)
			can_fire = false
			yield(get_tree().create_timer(0.05),"timeout")
			can_fire = true
			
func _process(delta):
	pos_diff = (DATA.ready_data.player_pos - global_position)
	match state:
		Auto:
			auto_state()
		remove:
			remove_state()
		


func _on_Auto_pressed():
	set_cam_off()
	world.not_drone_mode()
	set_cam_off()
	world.not_drone_mode()
	$CollisionShape2D.disabled = true
	$CanvasLayer/Drone_control.hide()
	$CanvasLayer/Drone_control.set_process_input(false)
	auto_enabled = true
	set_process(true)
	state = Auto
	button_displays()
	$CanvasLayer/shootbutton.hide()

func _on_remove_pressed():
	set_cam_off()
	auto_enabled = false
	world.not_drone_mode()
	$CanvasLayer/shootbutton.hide()
	$CollisionShape2D.disabled = true
	$CanvasLayer/Drone_control.hide()
	$CanvasLayer/Drone_control.set_process_input(false)
	set_physics_process(false)
	set_process(true)
	state = remove
	button_displays()

func _on_control_pressed():
	$CanvasLayer/shootbutton.show()
	auto_enabled = false
	set_cam_on()
	set_process(false)
	set_physics_process(true)
	$CollisionShape2D.disabled = false
	$CanvasLayer/Drone_control.show()
	$CanvasLayer/Drone_control.set_process_input(true)
	world.drone_mode()
	state = control
	button_displays()

func follow_state():
	if pos_diff.length() > 300:
		linear_velocity = pos_diff/2.5
		
	else:
		linear_velocity = Vector2.ZERO
	if pos_diff.x < 0:
		$Sprite.scale.x = 0.5
	else:
		$Sprite.scale.x = -0.5


func auto_state():
	if Enemy != null and pos_diff.length() < 500:
		linear_velocity = (Enemy.global_position - global_position)- Vector2(200,20)
		if (Enemy.global_position - global_position).x < 0:
			$Sprite.scale.x = 0.5
		else:
			$Sprite.scale.x = -0.5
	else:
		linear_velocity = pos_diff/2.5
		if pos_diff.x < 0:
			$Sprite.scale.x = 0.5
		else:
			$Sprite.scale.x = -0.5


func remove_state():
	if pos_diff.x < 0:
		$Sprite.scale.x = 0.5
	else:
		$Sprite.scale.x = -0.5
		
	if  pos_diff.length() < 200:
		world.get_node("CanvasLayer/DroneButton").show()
		queue_free()
	else:
		linear_velocity = pos_diff


func button_displays():
	for n in range(1,$CanvasLayer/Panel.get_child_count()+1):
		if n != state+1:
			$CanvasLayer/Panel.get_child(n-1).self_modulate = not_selected
		else:
			$CanvasLayer/Panel.get_child(n-1).self_modulate = selected



func _on_EnemyDetector_body_entered(body):
	Enemy = body

func _on_EnemyDetector_body_exited(body):
	Enemy = null

func _on_shootbutton_toggled(button_pressed):
	if button_pressed == true:
		start_fire = true
	else:
		start_fire = false
