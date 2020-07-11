extends Node2D


var map_name = "SNOW ISLAND"
onready var playercam
var wintermap = preload("res://MAIN/WinterBackground.tscn")
var player = "res://MAIN/Player.tscn"
var player_form
var vehicle
var vehicle_detected
var zoomvalue = Vector2(1,1)

func _ready():
	DATA.new_game()
	add_player()
	player_form = "man"
	$CanvasLayer/change_vehicle.hide()

	Signals.connect("vehicle_detected",self,"_on_vehicle_detected")
	Signals.connect("vehicle_undetected",self,"_on_vehicle_undetected")
	
	add_child(preload("res://MAIN/LoadingScreen.tscn").instance())
	
func _process(delta):
	$CanvasLayer/FpsLabel.text = str("FPS: ",Engine.get_frames_per_second())
	playercam = vehicle.get_node("Camera2D")
	playercam.zoom = zoomvalue
	DATA.ready_data.player_pos = vehicle.position
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
		vehicle.entered_mode()
		$CanvasLayer/aim_joystick.hide()
		$Vehicles.add_child_below_node($Vehicles.get_child($Vehicles.get_child_count()-1),vehicle,true)
		player_form = "vehicle"
		
		
	elif player_form == "vehicle":
		vehicle.parking_mode()
		add_player()
		$CanvasLayer/aim_joystick.show()

func _on_vehicle_detected():
	if player_form == "man":
		$CanvasLayer/change_vehicle.show()


func _on_vehicle_undetected():
	if player_form == "man":
		$CanvasLayer/change_vehicle.hide()
