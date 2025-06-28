extends Control

var act = false
@onready var drop_down_menu = $CanvasLayer/Res/OptionButton

func _input(event):
	if Input.is_action_just_pressed("ui_cancel"):
		if act == false:
			$CanvasLayer.show()
			get_tree().paused = true
			act = true
		else:
			$CanvasLayer.hide()
			get_tree().paused = false
			act = false
		#paused_mode = Node.PAUSE_MODE_PROCESS
func _ready():
	add_item()
func _on_contin_pressed():
	$CanvasLayer.hide()
	get_tree().paused = false
	act = false

func _on_exit_pressed():
	get_tree().quit()

func _on_menu_pressed():
	Music.stop()
	get_tree().change_scene_to_file("res://World/MainMenu.tscn")

func _on_button_pressed():
	$CanvasLayer/Res.hide()
	$CanvasLayer/VBoxContainer.show()

func _on_resol_pressed():
	$CanvasLayer/Res.show()
	$CanvasLayer/VBoxContainer.hide()

func add_item():
	drop_down_menu.add_item("1920x1080")
	drop_down_menu.add_item("1600x900")
	drop_down_menu.add_item("1280x720")
	drop_down_menu.add_item("1024x546")

func _on_option_button_item_selected(index):
	var current_selected = index
	if current_selected == 0:
		DisplayServer.window_set_size(Vector2(1920,1080))
	if current_selected == 1:
		DisplayServer.window_set_size(Vector2(1600,900))
	if current_selected == 2:
		DisplayServer.window_set_size(Vector2(1280,720))
	if current_selected == 3:
		DisplayServer.window_set_size(Vector2(1024,546))
