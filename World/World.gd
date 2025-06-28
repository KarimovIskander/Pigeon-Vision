extends Node2D

@onready var player = $Bird
@export var game = 0
# Refrence the save resource
var save: SaveGame 
var globs = Global
#------Cloud
@export var tim = 2.0
@export var timstart = 1.0
const c1Path = preload("res://Objects/Clouds/cloud.tscn")
const c2Path = preload("res://Objects/Clouds/cloud2.tscn")
const c3Path = preload("res://Objects/Clouds/cloud3.tscn")
#------
func _ready() -> void:
	globs.load_game_main.connect(load_game_main)
	globs.save_game_main.connect(save_game_main)
	create_or_load_save()

################################################################################
## Saves ##
func create_or_load_save():
	if SaveGame.save_exists('auto'):
		load_game_main('auto')
	else:
		save_game_main('auto')

func save_game_main(id: String):
	# new SaveGame resource
	save = SaveGame.new()
	if game == 0:
		game = 1
		print(game)
	## Stuff to save (player_position & save_date)
	save.player_position = player.global_position
	save.game = game
	save.this_save_date = Time.get_datetime_string_from_system()
	# saves 
	save.write_savegame(id)
	
	# Game updates after save done
	globs.update_save_dates()
	globs.emit_signal('updated_save')

func save_game_main2(id: String):
	# new SaveGame resource
	save = SaveGame.new()
	if game == 0:
		game = 1
		print(game)
	## Stuff to save (player_position & save_date)
	save.player_position = Vector2(-990.636, 19628.3)
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
	if game == 1 or game == 2:
		player.global_position = save.player_position
	# Game updates after load done
	globs.update_save_dates()
	globs.emit_signal('updated_save')
func updategame():
	pass
func shoot():
	var cloud1 = c1Path.instantiate()
	var cloud2 = c2Path.instantiate()
	var cloud3 = c3Path.instantiate()
	get_parent().add_child(cloud1)
	get_parent().add_child(cloud2)
	get_parent().add_child(cloud3)
	cloud1.position = $ScreenCamera/Marker2D.global_position
	cloud1.velocity = $ScreenCamera/Marker2D4.global_position - cloud1.position
	cloud2.position = $ScreenCamera/Marker2D2.global_position
	cloud2.velocity = $ScreenCamera/Marker2D5.global_position - cloud2.position
	cloud3.position = $ScreenCamera/Marker2D3.global_position
	cloud3.velocity = $ScreenCamera/Marker2D6.global_position - cloud3.position
	
	cloud1.position = $ScreenCamera/Marker2D7.global_position
	cloud1.velocity = $ScreenCamera/Marker2D10.global_position - cloud1.position
	cloud2.position = $ScreenCamera/Marker2D8.global_position
	cloud2.velocity = $ScreenCamera/Marker2D11.global_position - cloud2.position
	cloud3.position = $ScreenCamera/Marker2D9.global_position
	cloud3.velocity = $ScreenCamera/Marker2D12.global_position - cloud3.position
	
	cloud1.position = $ScreenCamera/Marker2D13.global_position
	cloud1.velocity = $ScreenCamera/Marker2D16.global_position - cloud1.position
	cloud2.position = $ScreenCamera/Marker2D14.global_position
	cloud2.velocity = $ScreenCamera/Marker2D17.global_position - cloud2.position
	cloud3.position = $ScreenCamera/Marker2D15.global_position
	cloud3.velocity = $ScreenCamera/Marker2D18.global_position - cloud3.position
	$ScreenCamera/Timer2.start()

func _on_timer_timeout():
	shoot()
func _on_area_2d_3_area_entered(area):
	game = 2
	save_game_main2('auto')
	$AudioStreamPlayer.play()
	$AnimationPlayer.play("new_animation")
