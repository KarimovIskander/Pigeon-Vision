extends CharacterBody2D

@onready var sprite = $AnimatedSprite2D
@export var facing_right = false
@export var SPEED = 400.0
@export var JUMP_VELOCITY = -400.0
@export var Death : PackedScene

var old = 0

signal light
signal justlight

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@export var move = false
#---------------------
@export var current_tilemap: TileMap
@export var dead_cell = "Dangeor"
@export var dead_cell_1 = "UpD"
@export var dead_cell_2 = "DownD"
var nfly = false
#---------------------
@export var actver1 = true 
@export var actver2 = true 
@export var actver3 = true 

func _ready():
	old = velocity.y
	Global.emit_signal("light")

func _process_tilemap_collision(body: Node2D,body_rid:RID) -> void:
	current_tilemap = body
	var collided_tile_coord = current_tilemap.get_coords_for_body_rid(body_rid)
	for index in current_tilemap.get_layers_count():
		var tile_data = current_tilemap.get_cell_tile_data(index,collided_tile_coord)
		if tile_data:
			#---------------------------------
			var Dangeor = tile_data.get_custom_data(dead_cell)
			if Dangeor: 
				Global.emit_signal("light")
				game_over()
			#---------------------------------
			var UpD = tile_data.get_custom_data(dead_cell_1)
			if UpD and velocity.y > old:
				Global.emit_signal("light")
				game_over()
			#---------------------------------
			var DownD = tile_data.get_custom_data(dead_cell_2)
			if DownD and velocity.y < old:
				Global.emit_signal("light")
				game_over()

func _input(event):
	pass
func _physics_process(delta):
	var move_dir = 0
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	#-------------------
	var direction = Input.get_axis("ui_left", "ui_right")
	if Input.is_action_pressed("ui_right"):
		move_dir -= 1
	if Input.is_action_pressed("ui_left"):
		move_dir += 1
	if Input.is_action_pressed("Slow"):
		SPEED = 270
		JUMP_VELOCITY = -350.0
	else:
		SPEED = 400
		JUMP_VELOCITY = -400.0
	if Input.is_action_pressed("ui_up"):
		velocity.x = 0
	if Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right"):
		if is_on_floor():
			$AnimatedSprite2D.play("Walk")
			if actver1 == true:
				$AudioStreamPlayer.play()
				actver1 = false
				actver2 = true
				actver3 = true
				$AudioStreamPlayer2.stop()
		else:
			$AnimatedSprite2D.play("Fly")
			if actver2 == true:
				$AudioStreamPlayer2.play()
				actver1 = true
				actver2 = false
				actver3 = true
				$AudioStreamPlayer.stop()
	else:
		if is_on_floor():
			$AnimatedSprite2D.play("default")
			if actver3 == true:
				$AudioStreamPlayer2.stop()
				$AudioStreamPlayer.stop()
				actver1 = true
				actver2 = true
				actver3 = false
		else:
			$AnimatedSprite2D.play("Fly")
			if actver2 == true:
				$AudioStreamPlayer2.play()
				actver1 = true
				actver2 = false
				actver3 = true
	# Handle Jump.
	if Input.is_action_pressed("ui_accept") and nfly == false:
		velocity.y = JUMP_VELOCITY
	#-------------------
	if direction:
		velocity.x = direction * SPEED
	#---------------------------
	var soud = true
	
	#-------------------
	if facing_right and move_dir < 0:
		flip()
	if !facing_right and move_dir > 0:
		flip()
	move_and_slide()

func flip():
	facing_right = !facing_right
	sprite.flip_h = !sprite.flip_h

func _on_area_2d_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if body is TileMap:
		_process_tilemap_collision(body, body_rid)

func audFly():
	$AudioStreamPlayer.play()
	$AudioStreamPlayer2.stop()

func audStep():
	$AudioStreamPlayer.stop()
	$AudioStreamPlayer2.play()

func game_over():
	var _particle = Death.instantiate()
	_particle.position = global_position
	_particle.rotation = global_rotation
	get_tree().current_scene.add_child(_particle)
	self.queue_free()

func _on_area_2d_area_entered(area):
	if area.is_in_group("Dead"):
		Global.emit_signal("light")
		game_over()
	if area.is_in_group("End1"):
		Global.emit_signal("justlight")
	if area.is_in_group("End2"):
		get_tree().change_scene_to_file("res://World/Cutscen_3.tscn")
	if area.is_in_group("NoFly"):
		nfly = true

