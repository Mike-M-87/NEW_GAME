extends Control

var data = {
	"money":10000000,
	"gun2_pur":false,
	"gun2_text":"GUN2 BUY 100/=",
	"gun2_avail":false,
	"rocketgun_pur":false,
	"rocketgun_text":"ROCKET GUN BUY 200/=",
	"rocketgun_avail":false,
	"player_pos":Vector2(),
	"camera_pos":Vector2()
	
}

func _ready():
	if load_data():
		$change_gun.text = data.gun2_text
		$RocketGun.text = data.rocketgun_text
		
		$Label.text = str(data.money)
func _process(delta):
	if load_data():
		$change_gun.text = data.gun2_text
		$RocketGun.text = data.rocketgun_text
		$Label.text = str(data.money)

func save_data():
	var file = File.new()
	file.open("user://data", File.WRITE_READ)
	file.store_var(data)
	
func load_data():
	var file = File.new()
	if !file.file_exists("user://data"):
		return false
	file.open("user://data",File.READ_WRITE)
	data = file.get_var()
	file.close()
	return true


func _on_change_gun_pressed():
	if data.gun2_pur == false:
		if data.money >= 100:
			data.gun2_pur = true
			data.money -= 100
			data.gun2_avail = true
			data.gun2_text = "EQUIPPED"
			
	elif data.gun2_avail == true:
		data.gun2_avail = false
		data.gun2_text = "EQUIP"

	elif data.gun2_avail == false:
		data.gun2_avail = true
		data.gun2_text = "EQUIPPED"
	save_data()

func _on_RocketGun_pressed():
	if data.rocketgun_pur == false:
		if data.money >= 200:
			data.rocketgun_pur = true
			data.money -= 200
			data.rocketgun_avail = true
			data.rocketgun_text = "EQUIPPED"
			
	elif data.rocketgun_avail == true:
		data.rocketgun_avail = false
		data.rocketgun_text = "EQUIP"
		
	elif data.rocketgun_avail == false:
		data.rocketgun_avail = true
		data.rocketgun_text = "EQUIPPED"
	save_data()

func _on_startgame_pressed():
	get_tree().change_scene("res://MAIN/World.tscn")

func _on_quit_pressed():
	get_tree().quit()



