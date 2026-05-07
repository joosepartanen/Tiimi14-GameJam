extends Node
signal score_changed(new_score : int)
var _score : int = 0
var _current_level : Level = null
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func reset() -> void:
	set_score(0)
	
func add_score(amount: int) -> void:
	if amount > 0:
		set_score(_score + amount)
	
func get_score() -> int:
	return _score

func set_score(new_score : int) -> void:
	_score = max(new_score, 0)
	score_changed.emit(_score)
	print(_score)
	if _score == 30:
		print("KASVU")
		#$AnimatedSprite2D.sprite_frames = load("res://Art/Kalakokeilu.tres")
	elif _score == 100:
		print("KASVU 2")
		#$AnimatedSprite2D.sprite_frames = load("res://Art/)


func register_current_level(new_level: Level) -> void:
	if _current_level == null:
		_current_level = new_level
