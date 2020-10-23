extends RigidBody2D

onready var Tank = get_parent().vehicle
onready var screenshake = get_node("../Camera2D/ScreenShake")
var dir

func _ready():
	screenshake.start(1,25,7)
	if Tank.sprite.scale.x > 0:
		$Sprite.rotation_degrees = 90
		dir = 1
	if Tank.sprite.scale.x < 0:
		$Sprite.rotation_degrees = -90
		dir = -1
	
	yield(get_tree().create_timer(0.6),"timeout")
	Tank.get_node("gunshot").play(1)
	
func _process(delta):
	if get_colliding_bodies() == []:
		$Sprite.rotation_degrees += delta*dir
		$CollisionShape2D.rotation_degrees += delta*dir
	$Sprite/boost.scale.y = linear_velocity.length()/8000

func _on_TankBullet_body_entered(body):
	Tank.get_node("gunshot").playing = false
	Events.big_explode(self,Tank.world,20000)
