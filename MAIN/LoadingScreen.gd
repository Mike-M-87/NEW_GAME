extends CanvasLayer

#export (String,FILE, "*tscn") var next_scene

func _ready():
	$Node2D/map_name.text  = get_parent().map_name
	$Node2D/Tween.interpolate_property($Node2D/loadingbar,"value",0,100,5,Tween.TRANS_SINE,Tween.EASE_IN_OUT)
	$Node2D/Tween.start()
	
	DATA.load_game_progress()
	DATA.load_characters_data()
	DATA.load_gun_data()
	yield($Node2D/Tween,"tween_completed")
	$Node2D/AnimationPlayer.play("hide")


func _on_AnimationPlayer_animation_finished(anim_name):
	queue_free()
