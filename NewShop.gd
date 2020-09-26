extends Node2D

var panelnumber = 1

func _ready():
	display_panel()
	update_visuals()
	
func _on_backButton_pressed():
	if panelnumber > 1 and panelnumber <= $Panels.get_child_count():
		panelnumber -= 1
	else:
		panelnumber = $Panels.get_child_count()
	display_panel()
	
func _on_nextButton_pressed():
	if panelnumber > 0 and panelnumber < $Panels.get_child_count():
		panelnumber += 1
	else:
		panelnumber = 1
	display_panel()
	
func display_panel():
	var col = [[0],[Color.red],[Color.blue],[Color.green]]

	for n in range(1,$Panels.get_child_count()+1):
		get_node("HBoxContainer/Button"+str(n)+"/ColorRect").hide()
	for n in range(1,$Panels.get_child_count()+1):
		get_node("Panels/Panel"+str(n)+"").hide()

	get_node("Panels/Panel"+str(panelnumber)+"").show()
	get_node("HBoxContainer/Button"+str(panelnumber)+"/ColorRect").show()
	$ColorRect.color = col[panelnumber][0]
	
func _on_back_pressed():
	get_tree().change_scene("res://MAIN/Menu.tscn")


func _on_Button1_pressed():
	panelnumber = 1
	display_panel()

func _on_Button2_pressed():
	panelnumber = 2
	display_panel()

func _on_Button3_pressed():
	panelnumber = 3
	display_panel()



	

func _on_buy_pistol1_pressed():
	if DATA.GunsData.Pistol1.purchase == false:
		if DATA.GameData.money >= 200:
			DATA.GunsData.Pistol1.purchase = true
			DATA.GameData.money -= 200
			DATA.GunsData.Pistol1.avail = true
			DATA.GunsData.Pistol1.button_text = "EQUIPPED"
	
	elif DATA.GunsData.Pistol1.avail == false:
		DATA.GunsData.Pistol1.avail = true
		DATA.GunsData.Pistol1.button_text = "EQUIPPED"
	
	elif DATA.GunsData.Pistol1.avail == true:
		DATA.GunsData.Pistol1.avail = false
		DATA.GunsData.Pistol1.button_text = "EQUIP"
		
	DATA.save_gun_data()
	DATA.save_game_progress()
	update_visuals()
	
	
func update_visuals():
	$Panels/Panel1/ScrollContainer/HBoxContainer/Pistol1/buy_pistol1.text = DATA.GunsData.Pistol1.button_text
	$Panels/Panel1/ScrollContainer/HBoxContainer/Pistol2/buy_pistol2.text = DATA.GunsData.Pistol2.button_text
	$Panels/Panel1/ScrollContainer/HBoxContainer/Pistol3/buy_pistol3.text = DATA.GunsData.Pistol3.button_text
	$Panels/Panel3/ScrollContainer/HBoxContainer/RPG0/buy_rpg0.text = DATA.GunsData.RPG0.button_text
	$Panels/Panel3/ScrollContainer/HBoxContainer/RPG1/buy_rpg1.text = DATA.GunsData.RPG1.button_text
	$CashPanel/MoneyLabel.text = str(DATA.GameData.money)
	$CashPanel/StarsLabel.text = str(DATA.GameData.star)

func _on_buy_pistol2_pressed():
	if DATA.GunsData.Pistol2.purchase == false:
		if DATA.GameData.money >= 100:
			DATA.GunsData.Pistol2.purchase = true
			DATA.GameData.money -= 100
			DATA.GunsData.Pistol2.avail = true
			DATA.GunsData.Pistol2.button_text = "EQUIPPED"

	elif DATA.GunsData.Pistol2.avail == false:
		DATA.GunsData.Pistol2.avail = true
		DATA.GunsData.Pistol2.button_text = "EQUIPPED"
		
	elif DATA.GunsData.Pistol2.avail == true:
		DATA.GunsData.Pistol2.avail = false
		DATA.GunsData.Pistol2.button_text = "EQUIP"
	DATA.save_gun_data()
	DATA.save_game_progress()
	update_visuals()


func _on_buy_pistol3_pressed():
	if DATA.GunsData.Pistol3.purchase == false:
		if DATA.GameData.money >= 100:
			DATA.GunsData.Pistol3.purchase = true
			DATA.GameData.money -= 100
			DATA.GunsData.Pistol3.avail = true
			DATA.GunsData.Pistol3.button_text = "EQUIPPED"

	elif DATA.GunsData.Pistol3.avail == false:
		DATA.GunsData.Pistol3.avail = true
		DATA.GunsData.Pistol3.button_text = "EQUIPPED"
		
	elif DATA.GunsData.Pistol3.avail == true:
		DATA.GunsData.Pistol3.avail = false
		DATA.GunsData.Pistol3.button_text = "EQUIP"
	DATA.save_gun_data()
	DATA.save_game_progress()
	update_visuals()


func _on_buy_rpg1_pressed():
	if DATA.GunsData.RPG1.purchase == false:
		if DATA.GameData.money >= 200:
			DATA.GunsData.RPG1.purchase = true
			DATA.GameData.money -= 200
			DATA.GunsData.RPG1.avail = true
			DATA.GunsData.RPG1.button_text = "EQUIPPED"
	
	elif DATA.GunsData.RPG1.avail == false:
		DATA.GunsData.RPG1.avail = true
		DATA.GunsData.RPG1.button_text = "EQUIPPED"
	
	elif DATA.GunsData.RPG1.avail == true:
		DATA.GunsData.RPG1.avail = false
		DATA.GunsData.RPG1.button_text = "EQUIP"
		
	DATA.save_gun_data()
	DATA.save_game_progress()
	update_visuals()

func _on_buy_rpg0_pressed():
	if DATA.GunsData.RPG0.purchase == false:
		if DATA.GameData.money >= 200:
			DATA.GunsData.RPG0.purchase = true
			DATA.GameData.money -= 200
			DATA.GunsData.RPG0.avail = true
			DATA.GunsData.RPG0.button_text = "EQUIPPED"
	
	elif DATA.GunsData.RPG0.avail == false:
		DATA.GunsData.RPG0.avail = true
		DATA.GunsData.RPG0.button_text = "EQUIPPED"
	
	elif DATA.GunsData.RPG0.avail == true:
		DATA.GunsData.RPG0.avail = false
		DATA.GunsData.RPG0.button_text = "EQUIP"
		
	DATA.save_gun_data()
	DATA.save_game_progress()
	update_visuals()
