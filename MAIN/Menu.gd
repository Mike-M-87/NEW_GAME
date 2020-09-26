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
	get_tree().change_scene("res://NewShop.tscn")


func _on_About_pressed():
	pass # Replace with function body.

func prime_factorisation(n):
	if n > 0:
		display(str(n)+"=")
		var count = 0
		while n%2==0:
			display(2)
			n = n/2
		for i in range(3,int(sqrt(n))+1,2):
			count += 1
			while n%i == 0:
				display(i)
				n=n/i
		if n > 2:
			display(n)
		print(count)
		textedit_display("",0)
	else:
		textedit_display("NUMBER MUST BE GRATER THAN ZERO",2)
		
func _input(event):
	if $TextEdit.text != null and event.is_action_pressed("ui_accept"):
		$Label.text = ""
		if $TextEdit.text.is_valid_float() or $TextEdit.text.is_valid_integer():
			var value_entered = int($TextEdit.text)
			prime_factorisation(value_entered)
		else:
			textedit_display("NUMBERS ONLY",2)
		
func display(value):
	$Label.text += str(value,",")

func textedit_display(value,time):
	$TextEdit.text = str(value)
	yield(get_tree().create_timer(time),"timeout")
	$TextEdit.text = ""
