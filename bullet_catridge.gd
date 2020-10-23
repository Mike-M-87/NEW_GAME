extends RigidBody2D

func _ready():
	rotation_degrees = rand_range(0,90)
	yield(get_tree().create_timer(5),"timeout")
	queue_free()

func _process(delta):
	modulate.a -= delta/2
