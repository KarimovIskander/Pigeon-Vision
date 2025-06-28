extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func play_music1():
	$Audio.play()

func play_music2():
	$Audio2.play()

func play_music4():
	$Wind.play()

func stop():
	$Audio.stop()
	$Audio2.stop()
	$Wind.stop()
