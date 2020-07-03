extends Node

#var config = ConfigFile.new()
#signal bullets_ready()

var def_bullet_data = {
	"gun1_tot_bullets":300,
	"gun1_bullets":50,
	"gun2_tot_bullets":200,
	"gun2_bullets":20,
	"rocket_tot_bullets":9,
	"rocket_bullets":3,
}
var bullet_data = {}

var def_gun_data = {
	"weapon":"res://MAIN/Gun.tscn",
	"weapon_pos":Vector2(50,2),
}
var gun_data = {}
#func _physics_process(delta):
	#DATA.gun_data.gun1_tot_bullets = clamp(DATA.gun_data.gun1_tot_bullets,0,default_gun_data.gun1_tot_bullets)
	#DATA.gun_data.gun2_tot_bullets = clamp(DATA.gun_data.gun2_tot_bullets,0,default_gun_data.gun2_tot_bullets)
#	pass
#func start():
#	var file = File.new()
#	if !file.file_exists("user://configfile"):
#		DATA.gun_data = DATA.default_gun_data
#		save_data_cfg()
#		save_data_cfg()
#		return false
#	return true
func new_game():
	DATA.bullet_data = def_bullet_data.duplicate(true)
	DATA.gun_data = def_gun_data.duplicate(true)

#func save_data_cfg():
#	DATA.config.save("user://configfile")
#	DATA.config.set_value("guns","gun_data",DATA.gun_data)
	
	
#func load_data_cfg():
#	if start():	
#		DATA.config.load("user://configfile")
#		DATA.gun_data = config.get_value("guns","gun_data",DATA.gun_data)
