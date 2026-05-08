extends PathFollow2D
class_name PathFollower

@export var speed : float = 50
@export var can_move : bool = true
var _path_length : float = -1
var _move_speed : float = 0
var direction : int = 1

func _process(delta: float) -> void:
	if not can_move or not _validate_path():
		push_warning("PathFollower: The follower can't move.")
		return
	
	var delta_ratio : float = _move_speed * delta * direction
	progress_ratio = clamp(progress_ratio + delta_ratio, 0, 1)
	
	if progress_ratio <= 0 or progress_ratio >= 1:
		direction *= -1
		

func _validate_path() -> bool:
	if _path_length >= 0:
		return true
	var path : Path2D = get_parent() as Path2D
	if path == null or path.curve == null:
		return false
	
	_path_length = path.curve.get_baked_length()
	_move_speed = speed / _path_length
	
	return true
