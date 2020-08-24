extends Panel


func _ready():
	$AnimationPlayer.play("PanelTexture")
	$Label2.text = str("FPS: ",Engine.get_frames_per_second(),".0")
