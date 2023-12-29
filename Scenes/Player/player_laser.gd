extends Area2D

@onready var player_laser: Area2D = $"."
@onready var explosion_radius: Area2D = $ExplosionRadius

const SPEED := 300

func _process(delta: float) -> void:
	position.y -= SPEED * delta
	
	var player_laser_overlaps = player_laser.get_overlapping_areas()
	if player_laser_overlaps:
		var explosion_overlaps = explosion_radius.get_overlapping_areas()
		for explosion_overlap in explosion_overlaps:
			explosion_overlap.queue_free()
			get_tree().call_group("ship", "decrease_player_laser_count")
		player_laser.queue_free()
#		emit_signal("update_missile_count")
#		get_tree().call_group("world", "decrease_missile_count")

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	get_tree().call_group("ship", "decrease_player_laser_count")
	queue_free()

func _on_explosion_radius_area_entered(area: Area2D) -> void:
	if area.is_in_group("alien"):
		get_tree().call_group("ship", "decrease_player_laser_count")
		get_tree().call_group("alien", "alien_speed_up")
	else:
		get_tree().call_group("ship", "decrease_player_laser_count")
#	queue_free()
	
