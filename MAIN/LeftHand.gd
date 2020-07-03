extends Sprite


var data = {
	"money":10000000,
	"gun2_pur":false,
	"gun2_text":"GUN2 BUY 100/=",
	"gun2_avail":false,
	"rocketgun_pur":false,
	"rocketgun_text":"ROCKET GUN BUY 200/=",
	"rocketgun_avail":false,
	"player_pos":Vector2(),
	"camera_pos":Vector2(),
}

onready var gun_button = get_parent().get_parent().get_parent().get_node("CanvasLayer").get_node("change_gun")
onready var joystick = get_parent().get_parent().get_parent().get_node("CanvasLayer/aim_joystick")
var joystick_value
onready var body = get_parent()
onready var Head = get_parent().get_node("Head")

var bullet_speed = 3000
var Gun

var rocketgun = "res://MAIN/RocketGun.tscn"
var gun2 = "res://MAIN/Gun2.tscn"
var gun1 = "res://MAIN/Gun.tscn"

func _ready():
	load_data()
	gun_button.connect("pressed",self,"on_changegun_pressed")
	Gun = load(DATA.gun_data.weapon).instance()
	Gun.position = DATA.gun_data.weapon_pos
	add_child(Gun)

func _process(delta):
	if DATA.gun_data.weapon == rocketgun:
		bullet_speed = 1500
	else:
		bullet_speed = 3000
	
	
	joystick_value = joystick.get_value() * 10

	Head.rotation_degrees = joystick_value.y * 4
	rotation_degrees = joystick_value.y * 10

	if joystick_value.x < 0:
		body.scale.x = -1
		Gun.rotation_deg_value = -rotation_degrees
		Gun.rotation_value = -rotation
		Gun.bullet_motion = Vector2(-bullet_speed,0)
	elif joystick_value.x > 0:
		body.scale.x = 1
		Gun.rotation_deg_value = rotation_degrees
		Gun.rotation_value = rotation
		Gun.bullet_motion = Vector2(bullet_speed,0)


func load_data():
	var file = File.new()
	if !file.file_exists("user://data"):
		return false
	file.open("user://data",File.READ_WRITE)
	data = file.get_var()
	file.close()
	return true
	
func save_data():
	var file = File.new()
	file.open("user://data", File.WRITE_READ)
	file.store_var(data)
	
func on_changegun_pressed():
	gun_button.get_parent().get_parent().get_node("press_sound").playing = true
	remove_child(Gun)
	check_gun1()
	Gun = load(DATA.gun_data.weapon).instance()
	Gun.position = DATA.gun_data.weapon_pos
	add_child(Gun)

func check_gun1():
	if DATA.gun_data.weapon == gun1:
		check_gun2()
	elif DATA.gun_data.weapon == gun2:
		check_rocketgun()
	elif DATA.gun_data.weapon == rocketgun:
		DATA.gun_data.weapon = gun1
		DATA.gun_data.weapon_pos = Vector2(50,2)

func check_gun2():
	if data.gun2_avail == true:
		DATA.gun_data.weapon = gun2
		DATA.gun_data.weapon_pos = Vector2(70,2)
	elif data.gun2_avail == false:
		check_rocketgun()

func check_rocketgun():
	if data.rocketgun_avail == true:
		DATA.gun_data.weapon = rocketgun
		DATA.gun_data.weapon_pos = Vector2(0,-50)
	elif data.rocketgun_avail == false:
		DATA.gun_data.weapon = gun1
		DATA.gun_data.weapon_pos = Vector2(50,2)
