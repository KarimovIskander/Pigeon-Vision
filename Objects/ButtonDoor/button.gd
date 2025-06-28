extends Area2D

@export var link_code: = 0
var press = false

signal actbut (value)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if press == false:
		$AudioStreamPlayer.play()
		press = true
		$AnimatedSprite2D.play("on")
		Global.emit_signal("actbut",link_code)
