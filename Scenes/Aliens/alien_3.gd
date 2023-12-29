extends Area2D

signal move_left
signal move_right

@onready var marker_2d: Marker2D = $Marker2D
@onready var timer: Timer = $Timer
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var speed_up: Timer = $SpeedUp


const ZIGZAG_MISSILE_SCENE = preload("res://Scenes/Missile/missile.tscn")

# As the player's score increases, the speed multiplier will increase
# making the aliens move faster as more are killed.
var speed_multiplier := 5.0
var current_speed :float
var move: float = 1

# How var down in pixels the aliens should move when they've reached
# the edge of the world.
var y_advacement := 10
var direction = "left"

func _ready() -> void:
	animation_player.play("walk")

func _process(delta: float) -> void:
#	pass
#	timer.wait_time = 0.5
	if direction == "left" and position.x >= 5:
		position.x -= speed_multiplier * delta * move
		if position.x <= 5:
			direction = "right"
			get_tree().call_group("alien", "_on_move_right")
	if direction == "right" and position.x <= 250:
		position.x += speed_multiplier * delta * move
		if position.x >= 250:
			direction = "left"
			get_tree().call_group("alien", "_on_move_left")

func _on_timer_timeout() -> void:
	if move:
		move = 0
		return
	else:
		move = 1

func _on_area_entered(area: Area2D) -> void:
	# TODO: add explosion animation
#	queue_free()
#	area.queue_free()
	pass

func _on_move_right() -> void:
	position.y += y_advacement
	direction = "right"

func _on_move_left() -> void:
	position.y += y_advacement
	direction = "left"

func fire() -> void:
	var zigzag_missile = ZIGZAG_MISSILE_SCENE.instantiate()
	zigzag_missile.global_position = global_position
	var world = get_tree().current_scene
	world.add_child(zigzag_missile)


func _on_speed_up_timeout() -> void:
	if timer.wait_time <= 0.3:
		return
	else:
		speed_multiplier += 2
		timer.wait_time -= .05
	print(timer.wait_time)

func alien_speed_up() -> void:
	if timer.wait_time <= 0.3:
		speed_multiplier += 1
		return
	else:
		speed_multiplier += 1
		timer.wait_time -= .03
