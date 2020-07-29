extends KinematicBody2D


onready var joystick = get_parent().get_parent().get_node("CanvasLayer/move_joystick")
var max_speed = 70
var gravity = 30
var velocity = Vector2()
var wintermap = preload("res://MAIN/WinterBackground.tscn")
var joystick_value
var bullet = preload("res://MAIN/TankBullet.tscn")
onready var world = get_parent().get_parent()
onready var sprite = $Sprite
var bullet_speed = 1500
var can_fire = true

func _ready():
	parking_mode()

func _physics_process(delta):
	joystick_value = joystick.get_value() * 10
	velocity.y += gravity
	velocity.x = (joystick_value.x * max_speed)
	
	if joystick_value.x > 0:
		sprite.flip_h = false
		$BulletPoint.position = Vector2(275,-65)
		bullet_speed = 1500
		$CollisionPolygon2D.scale.x = 1
		$Tween.interpolate_property(self,"rotation_degrees",self.rotation_degrees, (joystick_value.y*2),0.2)
		$Tween.start()
		
	elif joystick_value.x < 0:
		sprite.flip_h = true
		$BulletPoint.position = Vector2(-275,-65)
		bullet_speed = -1500
		$CollisionPolygon2D.scale.x = -1
		$Tween.interpolate_property(self,"rotation_degrees",self.rotation_degrees, -(joystick_value.y * 2),0.2)
		$Tween.start()
	
	
	if joystick_value.y == 0:
		$Tween.interpolate_property(self,"rotation_degrees",self.rotation_degrees,0.0,0.2)
		$Tween.start()
		
	elif joystick_value.y > 0:
		rotation_degrees = 0
		$Tween.stop_all()
		
	if rotation_degrees > 20:
		rotation_degrees = 20
	elif rotation_degrees < -20:
		rotation_degrees = -20
	velocity = move_and_slide(velocity)

func _on_TouchScreenButton_pressed():
	if can_fire:
		var bullet_instance = bullet.instance()
		bullet_instance.position = $BulletPoint.global_position
		bullet_instance.rotation_degrees = rotation_degrees
		bullet_instance.apply_impulse(Vector2(0,0),Vector2(bullet_speed,0).rotated(rotation))
		world.add_child(bullet_instance)
		$AudioStreamPlayer.playing = true
		can_fire = false
		yield(get_tree().create_timer(1),"timeout")
		can_fire = true

func parking_mode():
	rotation_degrees = 0
	set_physics_process(false)
	$CanvasLayer/TouchScreenButton.hide()
	$Camera2D.current = false
	

func entered_mode():
	$CanvasLayer/TouchScreenButton.show()
	$Camera2D.current = true
	set_physics_process(true)
