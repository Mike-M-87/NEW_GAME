extends Node

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

func new_game():
	DATA.bullet_data = def_bullet_data.duplicate(true)
	DATA.gun_data = def_gun_data.duplicate(true)
