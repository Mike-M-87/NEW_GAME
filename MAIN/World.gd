extends Node2D

onready var playercam
var player = "res://MAIN/Player.tscn"
var player_form
var vehicle
var vehicle_detected
var zoomvalue = Vector2(1,1)
var vehicle_camera = preload("res://MAIN/VehicleCamera2D.tscn").instance()
var gun_property = []
var gun_detected
var prev_gun
var dropping_gun

func _ready():
	yield(DATA.new_game(),"completed")
	add_player()
	$CanvasLayer/change_vehicle.hide()
	$CanvasLayer/PickGun.hide()
	Signals.connect("gun_detected",self,"gun_detected")
	Signals.connect("gun_undetected",self,"gun_undetected")
	Signals.connect("vehicle_detected",self,"_on_vehicle_detected")
	Signals.connect("vehicle_undetected",self,"_on_vehicle_undetected")

	
func _process(delta):
	$CanvasLayer/FpsLabel.text = str("FPS: ",Engine.get_frames_per_second())
	if player_form == "tank":
		DATA.ready_data.player_pos = vehicle.get_node("body").global_position
	elif player_form == "helicopter":
		DATA.ready_data.player_pos = vehicle.position
	elif player_form == "man":
		DATA.ready_data.player_pos = vehicle.position
	
	if player_form == "tank" or player_form == "helicopter":
		if vehicle.position.x <= 0:
			vehicle.position.x = 0
		if vehicle.position.x >= 9000:
			vehicle.position.x = 9000
	
	
func _on_MENU_pressed():
	get_tree().change_scene("res://MAIN/Menu.tscn")

func _on_ZoomCam_pressed():
	$press_sound.playing = true
	if zoomvalue == Vector2(1,1):
		zoomvalue = Vector2(2,2)
	elif zoomvalue == Vector2(2,2):
		zoomvalue = Vector2(1,1)
	$Camera2D.zoom = zoomvalue

func add_player():
	vehicle = load(player).instance()
	vehicle.position = DATA.ready_data.player_pos
	add_child(vehicle)
	player_form = "man"

func _on_change_vehicle_pressed():
	$buttons_timer.start(0.2)
	yield(self.get_node("buttons_timer"),"timeout")
	$buttons_timer.stop()
	
	$CanvasLayer/change_vehicle.show()
	$press_sound.play()
	
	if player_form == "man":
		vehicle.queue_free()
		vehicle = vehicle_detected
		if vehicle.is_in_group("tank"):
			vehicle.entered_mode()
			player_form = "tank"
		elif vehicle.is_in_group("helicopter"):
			vehicle.entered_mode()
			player_form = "helicopter"

		$CanvasLayer/aim_joystick.hide()
		$Vehicles.add_child_below_node($Vehicles.get_child($Vehicles.get_child_count()-1),vehicle,true)

	elif player_form == "tank" or player_form == "helicopter":
		vehicle.parking_mode()
		add_player()
		$CanvasLayer/aim_joystick.show()
		
func _on_PickGun_pressed():
	yield(get_node("Player/BodyRig/LeftHand").pick_gun(gun_detected.properties),"completed")
	$CanvasLayer/PickGun.hide()
	dropping_gun.position = gun_detected.position
	dropping_gun.position.y -= 25
	$Guns.add_child(dropping_gun)
	gun_detected.queue_free()
	
func _on_vehicle_detected():
	if player_form == "man":
		$CanvasLayer/change_vehicle.show()

func _on_vehicle_undetected():
	if player_form == "man":
		$CanvasLayer/change_vehicle.hide()
	
	
func gun_detected():
	$CanvasLayer/PickGun.show()

func gun_undetected():
	$CanvasLayer/PickGun.hide()

