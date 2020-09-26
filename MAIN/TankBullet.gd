extends RigidBody2D

onready var Tank = get_parent().vehicle
onready var screenshake = get_node("../Camera2D/ScreenShake")
var dir

func _ready():
	screenshake.start(1,20,5,3)
	if Tank.sprite.scale.x > 0:
		$Sprite.rotation_degrees = 90
		dir = 1
	if Tank.sprite.scale.x < 0:
		$Sprite.rotation_degrees = -90
		dir = -1
	
	yield(get_tree().create_timer(3),"timeout")
	Events.big_explode(self,Tank.world,15000)
	
func _process(delta):
	if get_colliding_bodies() == []:
		$Sprite.rotation_degrees += delta*dir
		$CollisionShape2D.rotation_degrees += delta*dir
	$Sprite/boost.scale.y = linear_velocity.length()/60000

func _on_TankBullet_body_entered(body):
	Events.big_explode(self,Tank.world,15000)
