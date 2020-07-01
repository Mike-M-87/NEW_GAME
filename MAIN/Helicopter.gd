extends KinematicBody2D

var velocity = Vector2()
onready var joystick = get_parent().get_node("CanvasLayer/move_joystick")
var joystick_value
var wintermap = preload("res://MAIN/WinterBackground.tscn")
var bullet = preload("res://MAIN/HeliBullet.tscn")
var can_fire = true
var fire_rate = 0.1
var bullet_speed = 1500
var can_start_fire = false
var bullet_motion = Vector2(-bullet_speed,0)
onready var world = get_parent()
onready var sprite = $Sprite

func _ready():
	parking_mode()
func _physics_process(delta):
	
	joystick_value = joystick.get_value() * 100
	velocity = joystick_value * 6
	
	
	if joystick_value.x < 0:
		$Sprite/Sprite2.position = Vector2(-35,-115)
		bullet_motion = Vector2(-bullet_speed,0)
		sprite.flip_h = false
		sprite.rotation_degrees = 5
		$CollisionPolygon2D.scale.x = 1
		$Sprite/BulletPoint.position = Vector2(-285,70)
		rotation_degrees = -15
	elif joystick_value.x > 0:
		$Sprite/Sprite2.position = Vector2(35,-115)
		bullet_motion = Vector2(bullet_speed,0)
		sprite.flip_h = true
		sprite.rotation_degrees = -5
		$CollisionPolygon2D.scale.x = -1
		$Sprite/BulletPoint.position = Vector2(275,70)
		rotation_degrees = 15
		
	if joystick_value == Vector2(0,0):
		velocity.y += 10
		$AnimationPlayer.stop()
		$Sprite/Sprite2.visible = false
	else:
		$AnimationPlayer.play("Rotor")
		$Sprite/Sprite2.visible = true
	velocity = move_and_slide(velocity)

	
	if velocity.y == 0:
		rotation_degrees = 0
	
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
	$WinterBackground.queue_free()
	global_position.y = 620
	rotation_degrees = 0
	set_physics_process(false)
	set_process(false)
	$CanvasLayer/TouchScreenButton.hide()
	$Camera2D.current = false


func entered_mode():
	add_child((wintermap).instance())
	set_process(true)
	set_physics_process(true)
	$CanvasLayer/TouchScreenButton.show()
	$Camera2D.current = true
	
