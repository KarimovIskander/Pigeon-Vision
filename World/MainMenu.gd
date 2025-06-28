extends Control

var volume = 30
var button_pressed = false

var n = true
var nw = true
var tr = true
var loc = true

var save: SaveGame 
var globs = Global
var zero = 0
@onready var drop_down_menu = $Res/OptionButton
@export var game = 0

const c1Path = preload("res://Objects/Clouds/cloud.tscn")
const c2Path = preload("res://Objects/Clouds/cloud2.tscn")
const c3Path = preload("res://Objects/Clouds/cloud3.tscn")

func add_item():
	drop_down_menu.add_item("1920x1080")
	drop_down_menu.add_item("1600x900")
	drop_down_menu.add_item("1280x720")
	drop_down_menu.add_item("1024x546")

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	get_tree().paused = false
	$ColorRect/AnimationPlayer.play("Show")
	add_item()
	globs.load_game_main.connect(load_game_main)
	shoot()
	Music.stop()
	Music.play_music4()
	create_or_load_save()
	if game == 2:
		$Con.show()

func create_or_load_save():
	if SaveGame.save_exists('auto'):
		load_game_main('auto')
	else:
		save_game_main('auto')

func save_game_main(id: String):
	# new SaveGame resource
	save = SaveGame.new()
	
	## Stuff to save (player_position & save_date)
	save.game = game
	save.this_save_date = Time.get_datetime_string_from_system()
	
	# saves 
	save.write_savegame(id)
	
	# Game updates after save done
	globs.update_save_dates()
	globs.emit_signal('updated_save')

func load_game_main(id: String):
	# Checks if save doesn't exist, 
	if SaveGame.save_exists(id) == false: return
	
	# loads save
	save = SaveGame.load_savegame(id) as SaveGame
	
	## Stuff to load (player_position)
	game = save.game
	
	# Game updates after load done
	globs.update_save_dates()
	globs.emit_signal('updated_save')
func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Hide":
		if nw == true:
			game = 0
			save_game_main('auto')
			get_tree().change_scene_to_file("res://World/Cutscen_1.tscn")
		else:
			Music.play_music2()
			get_tree().change_scene_to_file("res://World/World.tscn")

#______________________________________________________________

func _on_NewGame_pressed():
	if n == true:
		$VBoxContainer.hide()
		$NW.show()
func _on_Yes_pressed():
	var nw = true
	$ColorRect/AnimationPlayer.play("Hide")
func _on_No_pressed():
	$VBoxContainer.show()
	$NW.hide()

#_______________________
func _on_Contin_pressed():
	nw = false
	$ColorRect/AnimationPlayer.play("Hide")

#_______________________
func _on_Guide_pressed():
	if n == true:
		$VBoxContainer.hide()
		$G.show()
func _on_Back_pressed():
	$VBoxContainer.show()
	$G.hide()

#_______________________
func _on_Exit_pressed():
	get_tree().quit()
#-----------------------------
func _on_Resol_pressed():
	if tr == true:
		$Res.show()
		$VBoxContainer.hide()
		tr = false

func _on_OptionButton_item_selected(index):
	var current_selected = index
	if current_selected == 0:
		DisplayServer.window_set_size(Vector2(1920,1080))
	if current_selected == 1:
		DisplayServer.window_set_size(Vector2(1600,900))
	if current_selected == 2:
		DisplayServer.window_set_size(Vector2(1280,720))
	if current_selected == 3:
		DisplayServer.window_set_size(Vector2(1024,546))

func _on_Button_pressed():
		$Res.hide()
		$VBoxContainer.show()
		tr = true

func _on_ER_pressed():
	if loc == true:
		$ER.text = "-ENG-"
		loc = false
		TranslationServer.set_locale("en")
	else:
		$ER.text = "-RUS-"
		loc = true
		TranslationServer.set_locale("ru")

func shoot():
	var cloud1 = c1Path.instantiate()
	var cloud2 = c2Path.instantiate()
	var cloud3 = c3Path.instantiate()
	get_parent().add_child(cloud1)
	get_parent().add_child(cloud2)
	get_parent().add_child(cloud3)
	cloud1.position = $Marker2D.global_position
	cloud1.velocity = $Marker2D4.global_position - cloud1.position
	cloud2.position = $Marker2D2.global_position
	cloud2.velocity = $Marker2D5.global_position - cloud2.position
	cloud3.position = $Marker2D3.global_position
	cloud3.velocity = $Marker2D6.global_position - cloud3.position
	$Timer.start()

func _on_timer_timeout():
	shoot()
