extends Sprite


onready var gun_button = get_parent().get_parent().get_parent().get_node("CanvasLayer").get_node("change_gun")
onready var joystick = get_parent().get_parent().get_parent().get_node("CanvasLayer/aim_joystick")
onready var body = get_parent()
onready var Head = get_parent().get_node("Head")
onready var world = get_parent().get_parent().get_parent()
onready var Player = get_parent().get_parent()

var joystick_value
var shoot_value
var bullet_speed = 3000
var Gun
var rocketgun = "res://MAIN/RocketGun.tscn"
var gun2 = "res://MAIN/Gun2.tscn"
var gun1 = "res://MAIN/Gun.tscn"

var checking = false
var Gun_avail = []
var gun_range = 0


func _ready():
	yield(DATA.new_game(),"completed")
	DATA.load_gun_data()
	check_gun_avail(1)
	gun_button.connect("pressed",self,"on_changegun_pressed")
	Gun = load(DATA.ready_data.weapon).instance()
	Gun.position = DATA.ready_data.weapon_pos
	add_child(Gun)

func _process(delta):
	joystick_value = joystick.get_value() * 10
	shoot_value = joystick.get_shoot_value()/10
	Head.rotation_degrees = joystick_value.y * 4
	rotation_degrees = joystick_value.y * 10

	if joystick_value != Vector2.ZERO:
		if DATA.ready_data.weapon == rocketgun:
			bullet_speed = 1500
		else:
			bullet_speed = 3000
		if joystick_value.x < 0:
			Player.flip_dir("left")
			Gun.rotation_deg_value = -rotation_degrees
			Gun.rotation_value = -rotation
			Gun.bullet_motion = Vector2(-bullet_speed,0)
		elif joystick_value.x > 0:
			Player.flip_dir("right")
			Gun.rotation_deg_value = rotation_degrees
			Gun.rotation_value = rotation
			Gun.bullet_motion = Vector2(bullet_speed,0)
	else:
		pass

func on_changegun_pressed():
	change_weapon()
	change_gun_anim()
	world.get_node("press_sound").playing = true
	remove_child(Gun)
#	check_gun1()
#	hold_gun()
	
func hold_gun():
	Gun = load(DATA.ready_data.weapon).instance()
	Gun.position = DATA.ready_data.weapon_pos
	add_child(Gun)

func check_gun1():
	if DATA.ready_data.weapon == gun1:
		check_gun2()
	elif DATA.ready_data.weapon == gun2:
		check_rocketgun()
	elif DATA.ready_data.weapon == rocketgun:
		return_gun_one()

func check_gun2():
	if DATA.GunsData.gun2.avail == true:
		DATA.ready_data.weapon = gun2
		DATA.ready_data.weapon_pos = Vector2(70,2)
	elif DATA.GunsData.gun2.avail == false:
		check_rocketgun()
	
func check_rocketgun():
	if DATA.GunsData.rocketgun.avail == true:
		DATA.ready_data.weapon = rocketgun
		DATA.ready_data.weapon_pos = Vector2(0,-50)
	elif DATA.GunsData.rocketgun.avail == false:
		return_gun_one()

func return_gun_one():
	DATA.ready_data.weapon = gun1
	DATA.ready_data.weapon_pos = Vector2(50,2)

func pick_gun(value,value_pos):
	set_process(false)
	yield(get_tree(),"idle_frame")
	world.get_node("press_sound").playing = true
	var prev_gun = (DATA.ready_data.weapon.trim_prefix("res://MAIN/").get_basename())
	world.dropping_gun = load("res://"+prev_gun+"Pickable.tscn").instance()
	remove_child(Gun)
	DATA.ready_data.weapon = str("res://MAIN/"+value+".tscn")
	DATA.ready_data.weapon_pos = (value_pos)
	hold_gun()
	change_gun_anim()
	
func change_gun_anim():
	set_process(false)
	Player.get_node("AnimationPlayer").play("changegun")
	yield(Player.get_node("AnimationPlayer"),"animation_finished")
	set_process(true)

func change_weapon():
	checking = true
	var counts = 0
	for guns in range(0,2):
		print(guns)
		if Gun_avail[guns] == true:
			break
			DATA.ready_data.weapon = "res://MAIN/Gun"+str(guns+1)+".tscn"
			hold_gun()
		counts += 1
	print("Counts:",counts)

func check_gun_avail(weapon):
	Gun_avail = [DATA.GunsData.gun2.avail,
				DATA.GunsData.rocketgun.avail,
				#DATA.GunsData.gun4.avail,
				#DATA.GunsData.gun5.avail,
				#DATA.GunsData.gun6.avail,
				#DATA.GunsData.gun7.avail,
				#DATA.GunsData.gun8.avail,
				]
	return Gun_avail[weapon]
	#if Gun_avail[weapon] == true:
	#	return Gun_avail[weapon]
	#else:
	#	return null




