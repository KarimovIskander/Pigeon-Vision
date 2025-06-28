extends Control


const SAVE_PATH_PACKED_SCENE := "user://save_packed_scene.scn"
var globs = Global
var load_save_label 

func _ready():
	$CanvasLayer/AnimationPlayer.play("Darker")
	Global.light.connect(light) 
	Global.justlight.connect(justlight)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
func light ():
	$CanvasLayer/AnimationPlayer.play("Lighter")
	$AudioStreamPlayer.play()

func justlight():
	$CanvasLayer/AnimationPlayer2.play("Lighter")

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "Lighter":
		$CanvasLayer/AnimationPlayer.play("Darker")
		get_tree().reload_current_scene()

func _on_animation_player_2_animation_finished(anim_name):
	if anim_name == "Lighter":
		$CanvasLayer/AnimationPlayer.play("Darker")
		get_tree().change_scene_to_file("res://World/Cutscen_2.tscn")
