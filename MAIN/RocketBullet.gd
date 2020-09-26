extends RigidBody2D

onready var LeftHand = get_node("../Player/BodyRig/LeftHand")
onready var Player = get_node("../Player")
onready var sprite = $Sprite
onready var world = get_parent()
onready var screenshake = get_node("../Camera2D/ScreenShake")
var dir

func _ready():
	screenshake.start()
	if LeftHand.joystick_value.x < 0:
		sprite.rotation_degrees = -90
		dir = -1
	elif LeftHand.joystick_value.x > 0:
		sprite.rotation_degrees = 90
		dir = 1
	else:
		dir = 1
		
	yield(get_tree().create_timer(3),"timeout")
	Events.big_explode(self,world)

func _process(delta):
	if get_colliding_bodies() == []:
		sprite.rotation_degrees += (delta*10)*dir
		$CollisionShape2D.rotation_degrees += delta*10*dir
	$Sprite/boost.scale.y = linear_velocity.length()/12000

func _on_RocketBullet_body_entered(body):
	Events.big_explode(self,world)
