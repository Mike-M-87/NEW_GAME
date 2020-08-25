extends Node

var config = ConfigFile.new()

var default_ready_data = {
	"player_pos":Vector2(100,0),
	"weapon":"res://MAIN/Gun0.tscn",
} 
var ready_data = {}

var bullets_data = []
var def_bullets_data = [
	[300,100,100,],
	[250,50,50],
	[200,50,50],
	[9,3,3]
]

var GunsData = {
	"Gun0":{
		"avail":true,
		"upgrades":0,
		"upg_money":150,
		"pos":Vector2(50,2),
	},
	"Gun1":{
		"avail":false,
		"purchase":false,
		"button_text":"BUY 50/=",
		"upgrades":0,
		"upg_money":150,
		"pos":Vector2(50,2),
	},
	"Gun2":{
		"purchase":false,
		"avail":false,
		"button_text":"BUY 100/=",
		"upgrades":0,
		"upg_money":300,
		"pos":Vector2(50,2),
	},
	"Gun3":{
		"purchase":false,
		"avail":false,
		"button_text":"BUY 200/=",
		"upgrades":0,
		"upg_money":0,
		"pos":Vector2(-50,2),
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


var Guns_avail = []
var total_guns
var change_gun_range = 0

func new_game():
	yield(get_tree(),"idle_frame")
	DATA.ready_data = DATA.default_ready_data.duplicate(true)
	DATA.bullets_data = DATA.def_bullets_data.duplicate(true)
	change_gun_range = 0

func _ready():
	check_data_file()

func availGuns():
	if check_data_file():
		Guns_avail = [
			GunsData.Gun0.avail,
			GunsData.Gun1.avail,
			GunsData.Gun2.avail,
			GunsData.Gun3.avail,
		]
	total_guns  = Guns_avail.size()

func save_gun_data():
	config.save("user://GameData")
	config.set_value("GUNS","GunsData",GunsData)

func load_gun_data():
	config.load("user://GameData")
	GunsData = config.get_value("GUNS","GunsData",GunsData)
	
#
#
#
#
#
func save_game_progress():
	config.save("user://GameData")
	config.set_value("GAME_PROGRESS","GameData",GameData)

func load_game_progress():
	config.load("user://GameData")
	GameData = config.get_value("GAME_PROGRESS","GameData",GameData)

#
#
#
#
#
#
func save_characters_data():
	config.save("user://GameData")
	config.set_value("CHARACTERS","CharactersData",CharactersData)

func load_characters_data():
	config.load("user://GameData")
	CharactersData = config.get_value("CHARACTERS","CharactersData",CharactersData)



func check_data_file():
	var file = File.new()
	if !file.file_exists("user://GameData"):
		save_game_progress()
		save_characters_data()
		save_gun_data()
		confirm_save()
		return false
	else:
		load_characters_data()
		load_game_progress()
		load_gun_data()
		return true
#
func confirm_save():
	config.save("user://GameData")
	config.save("user://GameData")
#
