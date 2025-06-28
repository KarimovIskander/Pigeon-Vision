extends Node

signal light
signal justlight
signal actbut (value)

signal load_game_main
signal save_game_main
signal updated_save

@onready var save_dates: Dictionary

func update_save_dates():
	var save: SaveGame
	if SaveGame.save_exists('auto'):
		save = SaveGame.load_savegame('auto') as SaveGame
		save_dates['auto'] = save.this_save_date

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_wind"):
		swap_fullscreen_mode()

func swap_fullscreen_mode():
	if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MAXIMIZED)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)

#---------------------------------------------

