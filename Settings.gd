extends Node2D


func _ready():
	update_sound_buttons()

func _on_sfx_toggled(button_pressed):
	if button_pressed == true:
		DATA.GameData.sfx = true
	elif button_pressed == false:
		DATA.GameData.sfx = false
	DATA.save_game_progress()
	update_sound_buttons()

func update_sound_buttons():
	$Panel/sfx.pressed = DATA.GameData.sfx
	$Panel/bgm.pressed = DATA.GameData.bgm


func _on_close_pressed():
	get_tree().change_scene("res://MAIN/Menu.tscn")


func _on_bgm_toggled(button_pressed):
	if button_pressed == true:
		DATA.GameData.bgm = true
	elif button_pressed == false:
		DATA.GameData.bgm = false
	DATA.save_game_progress()
	update_sound_buttons()
