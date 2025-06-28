extends CharacterBody2D

const SPEED = 5500.0

func _physics_process(delta):
	velocity = velocity.normalized() * delta * SPEED
	move_and_slide()

func _on_area_2d_area_entered(area):
	self.queue_free()
