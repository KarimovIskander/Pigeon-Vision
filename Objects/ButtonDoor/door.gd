extends StaticBody2D

@export var link_code: int = 0
@export var hdoor: bool = false
var self_code = 0

 
func _ready() -> void:
	self_code = link_code
	Global.actbut.connect(actbut) 
	if hdoor == true:
		get_node("CollisionShape2D").set_deferred("disabled", true)
		$AnimationPlayer.play("Open")

func actbut(link_code):
	if self_code == link_code:
		if hdoor == false:
			get_node("CollisionShape2D").set_deferred("disabled", true)
			$AnimationPlayer.play("Open")
		else:
			get_node("CollisionShape2D").set_deferred("disabled", false)
			$Sprite2D.show()
