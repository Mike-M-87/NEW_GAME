extends KinematicBody2D

var speed = Vector2()
var gravity = 200
func _ready():
	set_physics_process(false)
func _physics_process(delta):
	speed.y += 20
	
	if Input.is_action_pressed("ui_left"):
		speed.x = -200
	elif Input.is_action_pressed("ui_right"):
		speed.x = 200
	else:
		speed.x = 0
	
	speed = move_and_slide(speed)
