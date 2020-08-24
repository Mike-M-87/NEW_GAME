extends RigidBody2D

onready var joystick = get_parent().get_node("CanvasLayer/Joystick")
var velocity = Vector2.ZERO
func _process(delta):
	if joystick.get_value().x > 0 or Input.is_action_pressed("ui_right"):
		velocity.x = 1
		#$Sprite.flip_h = true
		#$CollisionPolygon2D.scale.x = -1
	elif joystick.get_value().x < 0 or Input.is_action_pressed("ui_left"):
		velocity.x = -1
		#$Sprite.flip_h = false
		#$CollisionPolygon2D.scale.x = 1
	elif joystick.get_value().x == 0  :
		velocity.x = 0
	if joystick.get_value().y > 0 or Input.is_action_pressed("ui_down"):
		velocity.y = 1
	elif joystick.get_value().y < 0 or Input.is_action_pressed("ui_up"):
		velocity.y = -1
	elif  joystick.get_value().y == 0:
		velocity.y = 0
	apply_impulse(Vector2(),velocity*10)
	bounce = 1
#	$Sprite.rotation = joystick.get_value().y
