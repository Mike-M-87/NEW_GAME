extends Control


func _ready():
	DATA.load_game_progress()
	$CashPanel/MoneyLabel.text = str(DATA.GameData.money)
	$CashPanel/StarsLabel.text = str(DATA.GameData.star)

func _on_startgame_pressed():
	get_tree().change_scene("res://MAIN/World.tscn")

func _on_quit_pressed():
	get_tree().quit()


func _on_shop_pressed():
	get_tree().change_scene("res://MAIN/Shop.tscn")
