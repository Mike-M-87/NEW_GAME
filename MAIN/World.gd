extends Node2D


enum {
	PLAYER,
	HELICOPTER,
	TANK
}

var player_object
var player_form
var vehicle
var vehicle_detected

var zoomvalue = 2
var gun_detected
var dropping_gun

onready var map = $CanvasLayer2
onready var aimline
onready var screenshake = $Camera2D/ScreenShake
onready var camera = $Camera2D

func _ready():
	yield(DATA.new_game(),"completed")
	yield(self.add_player(),"completed")
	$CanvasLayer/change_vehicle.hide()
	$CanvasLayer/PickGun.hide()
	
	Signals.connect("gun_detected",self,"gun_detected")
	Signals.connect("gun_undetected",self,"gun_undetected")
	Signals.connect("vehicle_detected",self,"_on_vehicle_detected")
	Signals.connect("vehicle_undetected",self,"_on_vehicle_undetected")

	
func _process(delta):
	$CanvasLayer/FpsLabel.text = str("FPS: ",Engine.get_frames_per_second())
	
	map.offset.x = -($Camera2D.global_position.x/40)
	
	match player_form:
		PLAYER:
			DATA.ready_data.player_pos = vehicle.global_position
		TANK:
			DATA.ready_data.player_pos = vehicle.get_node("body").global_position

		HELICOPTER:
			DATA.ready_data.player_pos = vehicle.global_position
	$"CanvasLayer/PickGun/circular-arrows".rotate(0.1)
	print($"CanvasLayer/PickGun/circular-arrows".rotation)
	
func _on_MENU_pressed():
	get_tree().change_scene("res://MAIN/Menu.tscn")

func _on_zoombutton_pressed():
	set_cam_zoom()
	
func set_cam_zoom():
	if zoomvalue < 3 and zoomvalue > 0:
		zoomvalue += 1
	else:
		zoomvalue = 2
	camera.zoom = Vector2(zoomvalue,zoomvalue)
	#set_aimline()
	$CanvasLayer/zoombutton/Label.text = str(zoomvalue)
	
func set_aimline():
	if player_form == PLAYER:
		aimline = $Player/BodyRig/LeftHand.Gun.get_node("AimLine/lines")
		aimline.position.x = camera.zoom.x*350
		print(aimline.position.x)


	
func add_player():
	yield(get_tree(),"idle_frame")
	player_object = preload("res://MAIN/Player.tscn").instance()
	vehicle = player_object
	player_object.position = DATA.ready_data.player_pos
	player_object.set_cam_on()
	add_child(player_object)
	player_form = PLAYER
#	set_aimline()

func _on_change_vehicle_pressed():
	match player_form:
		PLAYER:
			player_object.hide()
			player_object.in_vehicle()
			vehicle = vehicle_detected
			vehicle.entered_mode()
			if vehicle.is_in_group("tank"):
				player_form = TANK
			elif vehicle.is_in_group("helicopter"):
				player_form = HELICOPTER
			
			$CanvasLayer/change_gun.hide()
		#	player_object.get_node("BodyRig/LeftHand").get_child(1).hide()
			$Vehicles.move_child(vehicle, $Vehicles.get_child_count())
			get_node("Player/BodyRig/LeftHand").get_child(1).get_node("ReloadButton/Node2D").hide()
		TANK:
			vehicle.parking_mode()
			vehicle = player_object
			player_object.off_vehicle()
			player_object.position = DATA.ready_data.player_pos 
			player_object.show()
			player_form = PLAYER
			$CanvasLayer/change_gun.show()
			get_node("Player/BodyRig/LeftHand").get_child(1).get_node("ReloadButton/Node2D").show()

		HELICOPTER:
			vehicle.parking_mode()
			vehicle = player_object
			player_object.off_vehicle()
			player_object.position = DATA.ready_data.player_pos 
			player_object.show()
			player_form = PLAYER
			$CanvasLayer/change_gun.show()
			$Vehicles.move_child(vehicle, $Vehicles.get_child_count())
			get_node("Player/BodyRig/LeftHand").get_child(1).get_node("ReloadButton/Node2D").show()
	
	$CanvasLayer/change_vehicle.show()
	$press_sound.play()
	$CanvasLayer/change_vehicle.show()


func _on_vehicle_detected():
	if player_form == PLAYER:
		$CanvasLayer/change_vehicle.show()

func _on_vehicle_undetected():
	if player_form == PLAYER:
		$CanvasLayer/change_vehicle.show()

func _on_DroneButton_pressed():
	if !self.has_node("Drone"):
		var drone = preload("res://Drone.tscn").instance()
		print(drone)
		drone.set_cam_on()
		drone.position = DATA.ready_data.player_pos
		add_child(drone)
		drone_mode()
		$CanvasLayer/DroneButton.hide()
		
func drone_mode():
	if vehicle == player_object:
		vehicle.in_vehicle()
	else:
		vehicle.parking_mode()
	$CanvasLayer/change_vehicle.disabled = true
	$CanvasLayer/change_gun.hide()
	$CanvasLayer/move_joystick.hide()
	$CanvasLayer/move_joystick.set_process_input(false)
	$CanvasLayer/aim_joystick.hide()
	$CanvasLayer/aim_joystick.set_process_input(false)
	$CanvasLayer/grenade.hide()

func not_drone_mode():
	if vehicle == player_object:
		vehicle.off_vehicle()
	else:
		vehicle.parking_mode()
	$CanvasLayer/change_vehicle.disabled = false
	$CanvasLayer/grenade.show()
	$CanvasLayer/change_gun.show()
	$CanvasLayer/move_joystick.show()
	$CanvasLayer/move_joystick.set_process_input(true)
	$CanvasLayer/aim_joystick.show()
	$CanvasLayer/aim_joystick.set_process_input(true)

