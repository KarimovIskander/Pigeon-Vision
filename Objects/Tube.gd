extends Node2D

@export var tim = 2.0
@export var timstart = 1.0
const bulletPath = preload("res://Objects/trash.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer2.start(timstart)
# Called every frame. 'delta' is the elapsed time since the previous frame.

func shoot():
	var bullet = bulletPath.instantiate()
	get_parent().add_child(bullet)
	bullet.position = $Marker2D.global_position
	bullet.velocity = $Marker2D2.global_position - bullet.position

func _on_timer_timeout():
	shoot()

func _on_timer_2_timeout():
	$Timer.start(tim)
