extends Node2D

@onready var aliens: Node2D = $Aliens

# Should not exceed 3
var total_missiles_onscreen = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
#	print(total_missiles_onscreen)

func _on_fire_missile_timeout() -> void:
	if total_missiles_onscreen >= 3:
		return
	var random_alien = aliens.get_children().pick_random()
	random_alien.fire()
	total_missiles_onscreen += 1
	
func decrease_missile_count() -> void:
	total_missiles_onscreen -= 1
	
