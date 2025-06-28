extends Resource
class_name SaveGame

#const SAVE_GAME_PATH := "user://saves/save_" # id will be added on when saved, i.e /save_1.tres
const SAVE_GAME_PATH := "user://save_"

## Things to save
@export var player_position := Vector2.ZERO
@export var this_save_date: String
@export var game = 0

# PackedScene i'm experimenting with
@export var main_packed_scene: PackedScene 

## Functions to writing to & load from file
func write_savegame(id: String) -> void:
	var save_path = str(SAVE_GAME_PATH + id + '.tres')
	ResourceSaver.save(self, save_path)

static func save_exists(id: String) -> bool:
	var save_path = str(SAVE_GAME_PATH + id + '.tres')
	return ResourceLoader.exists(save_path)

static func load_savegame(id: String) -> Resource:
	var save_path = str(SAVE_GAME_PATH + id + '.tres')
	return ResourceLoader.load(save_path, "", 2)
