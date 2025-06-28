extends TextureRect

@export var wait = 5
@export var act = false 

func _ready():
	$Timer.wait_time = wait
func _on_Timer_timeout():
	if act == false:
		$AnimationPlayer.play("T")
		act = true
func _on_area_2d_area_entered(area):
	$Timer.start()

