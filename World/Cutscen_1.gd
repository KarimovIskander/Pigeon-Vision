extends Control

@export var wait = 1
@export var wait2 = 5
@export var wait3 = 5
var act = true
@export var menu = false
@export var trap = false

func _ready():
	$Timer.wait_time = wait
	$Timer2.wait_time = wait2
	$Timer3.wait_time = wait3
	$Timer.start()
	if trap ==  true:
		Music.stop()

func _on_timer_timeout():
	$AnimationPlayer.play("hide")
	$Timer2.start()
	act = false
	if trap == true:
		$AudioStreamPlayer.play()

func _on_timer_2_timeout():
	$AnimationPlayer.play("L1")
	$Timer3.start()

func _on_timer_3_timeout():
	$AnimationPlayer.play("L2")

func _physics_process(delta):
	if Input.is_action_just_pressed("ui_accept") and act == false:
		act = true
		$AnimationPlayer.play("show")

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "show":
		Music.play_music2()
		if menu == false:
			get_tree().change_scene_to_file("res://World/World.tscn")
		else:
			get_tree().change_scene_to_file("res://World/MainMenu.tscn")
