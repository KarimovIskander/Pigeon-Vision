extends Area2D

var sleep = false
var save 
var load_save_label 

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	$Timer.start()
	if body.name == 'Bird' and sleep == false:
		Global.emit_signal('save_game_main', 'auto')
		$AudioStreamPlayer.play()
		$AnimationPlayer.play("An")
	sleep = true

func _on_timer_timeout():
	sleep = false
	
