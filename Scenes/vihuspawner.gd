extends Node2D

@export var enemy_scene: PackedScene

@onready var spawn_points = $Path2D.get_children()

func spawn_enemy():
	var spawn = spawn_points.pick_random()

	var enemy = enemy_scene.instantiate()

	# Add enemy TO the PathFollow2D
	spawn.add_child(enemy)

	# Reset local position
	enemy.position = Vector2.ZERO
