extends Node2D

var config = ConfigFile.new()
var gun_data = {}

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

onready var playercam
var wintermap = preload("res://MAIN/WinterBackground.tscn")
var player = "res://MAIN/Player.tscn"
var player_form
var vehicle
var vehicle_detected
var zoomvalue = Vector2(1,1)


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

func _ready():
	DATA.new_game()
	load_data()
	vehicle = load(player).instance()
	vehicle.position = Vector2(299.8,498.497)
	add_child(vehicle)
	player_form = "man"
	$CanvasLayer/change_vehicle.hide()

	Signals.connect("vehicle_detected",self,"_on_vehicle_detected")
	Signals.connect("vehicle_undetected",self,"_on_vehicle_undetected")
	
func _process(delta):
	playercam = vehicle.get_node("Camera2D")
	playercam.zoom = zoomvalue
	data.player_pos = vehicle.position
	data.camera_pos = playercam.global_position
	save_data()
	if player_form == "vehicle":
		if vehicle.position.x <= 0:
			vehicle.position.x = 0
		if vehicle.position.x >= 4800:
			vehicle.position.x = 4800
		
	
func _on_MENU_pressed():
	get_tree().change_scene("res://MAIN/Menu.tscn")


func _on_ZoomCam_pressed():
	$press_sound.playing = true
	if zoomvalue == Vector2(1,1):
		zoomvalue = Vector2(2,2)
	elif zoomvalue == Vector2(2,2):
		zoomvalue = Vector2(1,1)

func add_player():
	vehicle = load(player).instance()
	if load_data():
		vehicle.position = data.player_pos
	add_child(vehicle)


func _on_change_vehicle_pressed():
	$press_sound.play()
	if player_form == "man":
		vehicle.queue_free()
		vehicle = vehicle_detected
		vehicle.entered_mode()
		player_form = "vehicle"
		$CanvasLayer/aim_joystick.hide()
		add_child_below_node(get_child(get_child_count()-1),vehicle,true)
		
		
	elif player_form == "vehicle":
		vehicle.parking_mode()
		add_player()
		$CanvasLayer/aim_joystick.show()
		player_form = "man"
	$CanvasLayer/change_vehicle.show()
	
func _on_vehicle_detected():
	if player_form == "man":
		$CanvasLayer/change_vehicle.show()

func _on_vehicle_undetected():
	if player_form == "man":
		$CanvasLayer/change_vehicle.hide()

func reset_bullet_data():
	DATA.gun_data = DATA.default_gun_data
	DATA.save_data_cfg()









