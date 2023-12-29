extends Area2D

@onready var marker_2d: Marker2D = $Marker2D

const SPEED := 100

var PLAYER_LASER_SCENE = preload("res://Scenes/Player/player_laser.tscn")
var player_laser_count = 0

func _process(delta: float) -> void:
#	print(player_laser_count)
	var direction = Input.get_axis("move_left", "move_right")
	if direction < 0:
		position.x -= SPEED * delta
	elif direction > 0:
		position.x += SPEED * delta
	if Input.is_action_just_pressed("fire"):
		if player_laser_count >= 1:
			return
		else:
			fire()

func fire() -> void:
	var player_laser = PLAYER_LASER_SCENE.instantiate()
	player_laser.position = marker_2d.global_position 
	var world = get_tree().current_scene
	world.add_child(player_laser)
	player_laser_count += 1

func decrease_player_laser_count() -> void:
	player_laser_count = 0
	pass
