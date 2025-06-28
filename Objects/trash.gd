extends CharacterBody2D


const SPEED = 20000.0

# Get the gravity from the project settings to be synced with RigidBody nodes.


func _physics_process(delta):
	velocity = velocity.normalized() * delta * SPEED
	move_and_slide()


func _on_area_2d_body_entered(body):
	self.queue_free()
