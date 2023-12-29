extends Area2D

signal update_missile_count

# The missle core that can collide with the shield. Need to know if it
# hit anything at all. Don't need to know about surrounding
# shield pixels. Only if it collided with anything.
@onready var missile: Area2D = $"."

# If missle detects a hit, then ask the ExplosionRadiusArea node what
# other Area2D's (i.e. individual shield pixels) it's overlapping with
# and damage and/or queue_free() them.
@onready var explosion_radius: Area2D = $ExplosionRadius

# When a missile is spawned, randomize the Transform properties somewhat to
# make the destruction more random.
@onready var collision_polygon_2d: CollisionPolygon2D = $ExplosionRadius/CollisionPolygon2D

# Replicate the falling missile animation
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	collision_polygon_2d.rotation = randf_range(-0.2,0.2)
	collision_polygon_2d.scale = Vector2(randf_range(0.75,1.75),randf_range(0.75,1.75))
#	print(collision_polygon_2d.rotation)
#	print(collision_polygon_2d.scale)
	animation_player.play("falling")

func _process(delta: float) -> void:
	position.y += 50 * delta
	var missile_overlaps = missile.get_overlapping_areas()
	if missile_overlaps:
		var explosion_overlaps = explosion_radius.get_overlapping_areas()
		for explosion_overlap in explosion_overlaps:
			explosion_overlap.queue_free()
			get_tree().call_group("ship", "decrease_player_laser_count")
		missile.queue_free()
		emit_signal("update_missile_count")
		get_tree().call_group("world", "decrease_missile_count")

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	missile.queue_free()
	emit_signal("update_missile_count")
	get_tree().call_group("world", "decrease_missile_count")
