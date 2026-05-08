extends Node2D

var saalis_scene = preload("res://Scenes/saalis2.tscn")
@export var spawn_margin: float = 50.0
var margin = randf_range(40, 80)

func _on_timer_timeout():
	spawn_saalis()

func spawn_saalis():
	var saalis = saalis_scene.instantiate()
	var screen_size = get_viewport_rect().size
	saalis.global_position = Vector2(
	-50,  # just outside left
	randf_range(0, screen_size.y))
	add_child(saalis)
