extends Control

var selected_panel_button_color = Color.blue
var normal_panel_button_color = Color.white


func _ready():
	DATA.load_gun_data()
	DATA.load_game_progress()
	$DronesPanel.visible = false
	$OpenGunPanel.modulate = Color.blue
	update_texts()

func _on_QuitShop_pressed():
	get_tree().change_scene("res://MAIN/Menu.tscn")

func _on_OpenGunPanel_pressed():
	$GunsPanel.visible = true
	$DronesPanel.visible = false
	$OpenDronesPanel.modulate = normal_panel_button_color
	$OpenGunPanel.modulate = selected_panel_button_color

func _on_OpenDronesPanel_pressed():
	$GunsPanel.visible = false
	$DronesPanel.visible = true
	$OpenGunPanel.modulate = normal_panel_button_color
	$OpenDronesPanel.modulate = selected_panel_button_color


func _on_purchaseGun2_pressed():
	if DATA.GunsData.gun2.purchase == false:
		if DATA.GameData.money >= 100:
			DATA.GunsData.gun2.purchase = true
			DATA.GameData.money -= 100
			DATA.GunsData.gun2.avail = true
			DATA.GunsData.gun2.button_text = "EQUIPPED"

	elif DATA.GunsData.gun2.avail == false:
		DATA.GunsData.gun2.avail = true
		DATA.GunsData.gun2.button_text = "EQUIPPED"
		
	elif DATA.GunsData.gun2.avail == true:
		DATA.GunsData.gun2.avail = false
		DATA.GunsData.gun2.button_text = "EQUIP"
	DATA.save_gun_data()
	DATA.save_game_progress()
	update_texts()

func _on_purchaseRocket_pressed():
	if DATA.GunsData.rocketgun.purchase == false:
		if DATA.GameData.money >= 200:
			DATA.GunsData.rocketgun.purchase = true
			DATA.GameData.money -= 200
			DATA.GunsData.rocketgun.avail = true
			DATA.GunsData.rocketgun.button_text = "EQUIPPED"
	
	elif DATA.GunsData.rocketgun.avail == false:
		DATA.GunsData.rocketgun.avail = true
		DATA.GunsData.rocketgun.button_text = "EQUIPPED"
	
	elif DATA.GunsData.rocketgun.avail == true:
		DATA.GunsData.rocketgun.avail = false
		DATA.GunsData.rocketgun.button_text = "EQUIP"
		
	
	DATA.save_gun_data()
	DATA.save_game_progress()
	update_texts()

func update_texts():
	$GunsPanel/Gun2/purchaseGun2.text = DATA.GunsData.gun2.button_text
	$GunsPanel/RocketGun/purchaseRocket.text = DATA.GunsData.rocketgun.button_text
	$CashPanel/MoneyLabel.text = str(DATA.GameData.money)
	$CashPanel/StarsLabel.text = str(DATA.GameData.star)
	

