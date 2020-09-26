extends Node

var amplitude_x = 0
var amplitude_y = 0
onready var camera = get_parent()
onready var timer = $Duration
var DAMP_EASING = 4

func start(duration = 0.5,amp_x = 4,amp_y = 4,damp = 4):
	DAMP_EASING = damp
	amplitude_x = amp_x
	amplitude_y = amp_y
	$Duration.wait_time = duration
	
	set_process(true)
	$Duration.start()
	$Duration.one_shot = true
	print(amplitude_x)

func _process(delta):
	var damping = ease(timer.time_left / timer.wait_time, DAMP_EASING)
	camera.offset = Vector2(
		rand_range(amplitude_x, -amplitude_x) * damping,
		rand_range(amplitude_y, -amplitude_y) * damping
		)
	
func _on_Duration_timeout():
	set_process(false)
	camera.offset = Vector2()
	$Duration.stop()
