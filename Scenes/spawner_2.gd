extends Node2D

var saalis_scene = preload("res://Scenes/Saalis.tscn")
@export var spawn_margin: float = 50.0

func _on_timer_timeout():
	spawn_saalis()

func spawn_saalis():
	var saalis = saalis_scene.instantiate()

	var screen_size = get_viewport_rect().size
	var side = randi() % 4  # 0=left, 1=right, 2=top, 3=bottom

	var pos = Vector2()

	match side:
		0: # LEFT
			pos.x = -spawn_margin
			pos.y = randf_range(0, screen_size.y)

		1: # RIGHT
			pos.x = screen_size.x + spawn_margin
			pos.y = randf_range(0, screen_size.y)

		2: # TOP
			pos.x = randf_range(0, screen_size.x)
			pos.y = -spawn_margin

		3: # BOTTOM
			pos.x = randf_range(0, screen_size.x)
			pos.y = screen_size.y + spawn_margin

	#saalis.global_position = pos
	saalis.direction = Vector2.RIGHT
	add_child(saalis)
