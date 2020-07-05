extends Node

var config = ConfigFile.new()


var default_ready_data = {
	"gun1_tot_bullets":300,
	"gun1_bullets":50,
	"gun2_tot_bullets":200,
	"gun2_bullets":20,
	"rocket_tot_bullets":9,
	"rocket_bullets":3,
	"player_pos":Vector2(100,0),
	"weapon":"res://MAIN/Gun.tscn",
	"weapon_pos":Vector2(50,2),
} 
var ready_data = {}


var GunsData = {
	"gun1":{
		"upgrades":0,
		"upg_money":150,
	},
	"gun2":{
		"purchase":false,
		"avail":false,
		"button_text":"BUY 100/=",
		"upgrades":0,
		"upg_money":300,
	},
	"rocketgun":{
		"purchase":false,
		"avail":false,
		"button_text":"BUY 200/=",
		"upgrades":0,
		"upg_money":0,
	},
}

var CharactersData = {
	"player_maxhealth":1,
	"player_damage":1,
	"enemy_damage":1,
	"enemy_maxhealth":1,
}
var GameData = {
	"level":1,
	"money":100000,
	"star":0,
}

func new_game():
	DATA.ready_data = DATA.default_ready_data.duplicate(true)
	pass
func _ready():
	var file = File.new()
	if !file.file_exists("user://GameData"):
		save_game_progress()
		save_characters_data()
		save_gun_data()
	else:
		load_characters_data()
		load_game_progress()
		load_gun_data()
	pass

func confirm_save():
	config.save("user://GameData")
	config.save("user://GameData")



func save_gun_data():
	config.save("user://GameData")
	config.set_value("GUNS","GunsData",GunsData)
	confirm_save()

func load_gun_data():
	config.load("user://GameData")
	GunsData = config.get_value("GUNS","GunsData",GunsData)
	





func save_game_progress():
	config.save("user://GameData")
	config.set_value("GAME_PROGRESS","GameData",GameData)
	confirm_save()

func load_game_progress():
	config.load("user://GameData")
	GameData = config.get_value("GAME_PROGRESS","GameData",GameData)
	


	
func save_characters_data():
	config.save("user://GameData")
	config.set_value("CHARACTERS","CharactersData",CharactersData)
	confirm_save()

func load_characters_data():
	config.load("user://GameData")
	CharactersData = config.get_value("CHARACTERS","CharactersData",CharactersData)
