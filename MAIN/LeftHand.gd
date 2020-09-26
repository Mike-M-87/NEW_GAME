extends Sprite


onready var change_gun = $"../../../CanvasLayer/change_gun"
onready var aim_joystick = $"../../../CanvasLayer/aim_joystick"
onready var body = $"../"
onready var Head = $"../Head"
onready var world = $"../../../"
onready var world_guns_node = $"../../../Guns"
onready var pick_gun = $"../../../CanvasLayer/PickGun"
onready var Player = $"../../"
onready var gun_store = $"../Head/GunStorage"

var rotation_deg_value = 0
var rotation_value = 0
var bullet_motion = Vector2()

var joystick_value

var shoot_value

var equipped_guns = [null,null]
var gun_detected
var current_gun
var drop_pos
var pos = Vector2(50,2)

func _ready():
	pick_gun.connect("pressed",self,"on_pickGun_pressed")
	DATA.availGuns()
	hold_gun()
	change_gun.connect("pressed",self,"on_changegun_pressed")
	
func _process(delta):
	
	joystick_value = aim_joystick.get_value() * 10
	shoot_value = aim_joystick.get_shoot_value()/10
	
	if aim_joystick.get_dir() > 0:
		body.scale.x = 1
		rotation_degrees = joystick_value.y * 10
		Head.rotation_degrees = rotation_degrees/2
		
	elif aim_joystick.get_dir() < 0:
		body.scale.x = -1
		rotation_degrees = joystick_value.y * 10 
		Head.rotation_degrees = rotation_degrees/2
	
	rotation_deg_value = rotation_degrees *aim_joystick.get_dir()
	rotation_value = rotation*aim_joystick.get_dir()
	bullet_motion = Vector2(current_gun.bullet_speed*aim_joystick.get_dir(),0)

func on_changegun_pressed():
	for i in equipped_guns:
		if i.get_parent().name == "LeftHand":
			store_Gun(i)
			
		elif i.get_parent().name == "GunStorage":
			add_gun_to_self(i,gun_store)

func hold_gun():
	equipped_guns[0] = preload("res://MAIN/Gun0.tscn").instance()
	equipped_guns[1] = preload("res://MAIN/Gun2.tscn").instance()
	equipped_guns[0].position = equipped_guns[0].weapon_pos
	add_child(equipped_guns[0])
	store_Gun(equipped_guns[1])
	Events.ready_weapon(equipped_guns[0])
	Events.ready_weapon(equipped_guns[1])
	current_gun = get_child(1)

func on_pickGun_pressed():
	current_gun = get_child(1)
	pick_gun.disabled = true
	$buttons_timer.start(0.5)
	yield($buttons_timer,"timeout")
	$buttons_timer.stop()
	if gun_detected.is_in_group("primary"):
		if current_gun.is_in_group("primary"):
			drop_Gun(equipped_guns[0],equipped_guns[0].get_parent(),gun_detected.global_position)
			add_gun_to_self(gun_detected,world_guns_node)
			equipped_guns[0] = gun_detected
			
		elif current_gun.is_in_group("secondary"):
			store_Gun(equipped_guns[1])
			drop_Gun(equipped_guns[0],equipped_guns[0].get_parent(),gun_detected.global_position)
			add_gun_to_self(gun_detected,world_guns_node)
			equipped_guns[0] = gun_detected
	elif gun_detected.is_in_group("secondary"):
		if current_gun.is_in_group("secondary"):
			drop_Gun(equipped_guns[1],equipped_guns[1].get_parent(),gun_detected.global_position)
			add_gun_to_self(gun_detected,world_guns_node)
			equipped_guns[1] = gun_detected
			
		elif current_gun.is_in_group("primary"):
			store_Gun(equipped_guns[0])
			drop_Gun(equipped_guns[1],equipped_guns[1].get_parent(),gun_detected.global_position)
			add_gun_to_self(gun_detected,world_guns_node)
			equipped_guns[1] = gun_detected
	pick_gun.disabled = false
	current_gun = get_child(1)
	
func _on_GunDetector_area_entered(area):
	if world.player_form == world.PLAYER and area.is_in_group("pickableGun") and area.get_parent().get_parent().name == "Guns":
		pick_gun.texture_normal = area.get_parent().get_node("Sprite").texture
		if area.get_parent().gun_name == equipped_guns[0].gun_name:
			Events.ammo_reload(equipped_guns[0],area.get_parent())
		elif area.get_parent().gun_name == equipped_guns[1].gun_name:
			Events.ammo_reload(equipped_guns[1],area.get_parent())
		else:
			gun_detected = area.get_parent()
			pick_gun.show()
	
			
func _on_GunDetector_area_exited(area):
	if area.is_in_group("pickableGun"):
		pick_gun.hide()
		
func drop_Gun(gun_node,parent,pos):
	if parent == gun_store:
		gun_store.remove_child(gun_node)
		print("press")
	elif parent == self:
		self.remove_child(gun_node)
	gun_node.global_position = pos
	world_guns_node.add_child(gun_node)
	Events.ready_weapon(gun_node)

func store_Gun(gun_node):
	remove_child(gun_node)
	gun_store.add_child(gun_node)
	gun_node.position = Vector2(0,0)
	Events.ready_weapon(gun_node)
	
func add_gun_to_self(gun_node,parent):
	if parent == gun_store:
		gun_store.remove_child(gun_node)
	elif parent == world_guns_node:
		world_guns_node.remove_child(gun_node)
		print("pp")
	add_child(gun_node)
	gun_node.position = gun_node.weapon_pos
	Events.ready_weapon(gun_node)
	

