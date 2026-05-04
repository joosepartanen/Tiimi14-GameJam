extends Node
signal score_changed(new_score : int)
var _score : int = 0
#var _health : int = 3

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
