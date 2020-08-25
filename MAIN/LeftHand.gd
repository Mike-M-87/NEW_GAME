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
	DATA.availGuns()
	hold_gun()
	gun_button.connect("pressed",self,"on_changegun_pressed")
	
func _process(delta):
	joystick_value = joystick.get_value() * 10
	shoot_value = joystick.get_shoot_value()/10
	Head.rotation_degrees = joystick_value.y * 4
	rotation_degrees = joystick_value.y * 10

	if joystick_value != Vector2.ZERO:
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

func on_changegun_pressed():
	change_gun_anim()
	world.get_node("press_sound").playing = true
	remove_child(Gun)
#	check_gun1()
#	hold_gun()
	change_weapon()

func hold_gun():
	Gun = load(DATA.ready_data.weapon).instance()
	Gun.position = Gun.weapon_pos
	add_child(Gun)

	
func change_weapon():
	if DATA.change_gun_range < DATA.total_guns-1:
		DATA.change_gun_range += 1
	else:
		DATA.change_gun_range = 0
		
	while DATA.change_gun_range < DATA.total_guns:
		if check_gun_avail(DATA.change_gun_range) == true:
			break
		else:
			if DATA.change_gun_range < DATA.total_guns-1:
				DATA.change_gun_range += 1
			else:
				DATA.change_gun_range = 0

	DATA.ready_data.weapon = "res://MAIN/Gun"+str(DATA.change_gun_range)+".tscn"
	hold_gun()
	
	
func check_gun_avail(value):
	if DATA.Guns_avail[value] == true:
		return true
	else:
		return false

func pick_gun(value):
	yield(get_tree(),"idle_frame")
	set_process(false)
	world.get_node("press_sound").playing = true
	var prev_gun = (DATA.ready_data.weapon.trim_prefix("res://MAIN/").get_basename())
	world.dropping_gun = load("res://"+prev_gun+"Pickable.tscn").instance()
	Gun.queue_free()
	DATA.ready_data.weapon = str("res://MAIN/"+str(value)+".tscn")
	hold_gun()
	change_gun_anim()
	
func change_gun_anim():
	set_process(false)
	Player.get_node("AnimationPlayer").play("changegun")
	yield(Player.get_node("AnimationPlayer"),"animation_finished")
	set_process(true)




