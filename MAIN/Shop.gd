extends Control

export var selected_panel_button_color = Color.blue
var normal_panel_button_color = Color.green


func _ready():
	DATA.load_gun_data()
	DATA.load_game_progress()
	$DronesPanel.visible = false
	$OpenGunPanel.self_modulate = Color.blue
	update_texts()

func _on_QuitShop_pressed():
	get_tree().change_scene("res://MAIN/Menu.tscn")

func _on_OpenGunPanel_pressed():
	$GunsPanel.visible = true
	$DronesPanel.visible = false
	$OpenDronesPanel.self_modulate = normal_panel_button_color
	$OpenGunPanel.self_modulate = selected_panel_button_color

func _on_OpenDronesPanel_pressed():
	$GunsPanel.visible = false
	$DronesPanel.visible = true
	$OpenGunPanel.self_modulate = normal_panel_button_color
	$OpenDronesPanel.self_modulate = selected_panel_button_color


func _on_purchaseGun2_pressed():
	if DATA.GunsData.Gun2.purchase == false:
		if DATA.GameData.money >= 100:
			DATA.GunsData.Gun2.purchase = true
			DATA.GameData.money -= 100
			DATA.GunsData.Gun2.avail = true
			DATA.GunsData.Gun2.button_text = "EQUIPPED"

	elif DATA.GunsData.Gun2.avail == false:
		DATA.GunsData.Gun2.avail = true
		DATA.GunsData.Gun2.button_text = "EQUIPPED"
		
	elif DATA.GunsData.Gun2.avail == true:
		DATA.GunsData.Gun2.avail = false
		DATA.GunsData.Gun2.button_text = "EQUIP"
	DATA.save_gun_data()
	DATA.save_game_progress()
	update_texts()

func _on_purchaseGun3_pressed():
	if DATA.GunsData.Gun3.purchase == false:
		if DATA.GameData.money >= 200:
			DATA.GunsData.Gun3.purchase = true
			DATA.GameData.money -= 200
			DATA.GunsData.Gun3.avail = true
			DATA.GunsData.Gun3.button_text = "EQUIPPED"
	
	elif DATA.GunsData.Gun3.avail == false:
		DATA.GunsData.Gun3.avail = true
		DATA.GunsData.Gun3.button_text = "EQUIPPED"
	
	elif DATA.GunsData.Gun3.avail == true:
		DATA.GunsData.Gun3.avail = false
		DATA.GunsData.Gun3.button_text = "EQUIP"
		
	DATA.save_gun_data()
	DATA.save_game_progress()
	update_texts()

func update_texts():
	$GunsPanel/Tier1_Guns/HBoxContainer/Gun1/purchaseGun1.text = DATA.GunsData.Gun1.button_text
	$GunsPanel/Tier1_Guns/HBoxContainer/Gun2/purchaseGun2.text = DATA.GunsData.Gun2.button_text
	$GunsPanel/Tier1_Guns/HBoxContainer/Gun3/purchaseGun3.text = DATA.GunsData.Gun3.button_text
	$CashPanel/MoneyLabel.text = str(DATA.GameData.money)
	$CashPanel/StarsLabel.text = str(DATA.GameData.star)
	pass




func _on_purchaseGun1_pressed():
	if DATA.GunsData.Gun1.purchase == false:
		if DATA.GameData.money >= 200:
			DATA.GunsData.Gun1.purchase = true
			DATA.GameData.money -= 200
			DATA.GunsData.Gun1.avail = true
			DATA.GunsData.Gun1.button_text = "EQUIPPED"
	
	elif DATA.GunsData.Gun1.avail == false:
		DATA.GunsData.Gun1.avail = true
		DATA.GunsData.Gun1.button_text = "EQUIPPED"
	
	elif DATA.GunsData.Gun1.avail == true:
		DATA.GunsData.Gun1.avail = false
		DATA.GunsData.Gun1.button_text = "EQUIP"
		
	DATA.save_gun_data()
	DATA.save_game_progress()
	update_texts()
