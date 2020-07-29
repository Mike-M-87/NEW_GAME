extends KinematicBody2D

var velocity = Vector2()
var can_see_player = false
func _ready():
	pass
	
func _physics_process(delta):
	velocity.y += 20
	print(can_see_player)
	if can_see_player:
		velocity = velocity.move_toward(get_parent().vehicle.position,5)
	else:
		velocity = Vector2(0,0)
	move_and_slide(velocity)	

func _on_PlayerDetector_body_entered(body):
	if body.is_in_group("player") or body.is_in_group("vehicle"):
		can_see_player = true

func _on_PlayerDetector_body_exited(body):
	if body.is_in_group("player") or body.is_in_group("vehicle"):
		can_see_player = false
