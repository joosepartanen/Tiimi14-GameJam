extends Collectable
class_name Saalis

@export var _score: int = 10
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
var _path_follower : PathFollower = null
var prev_pos: Vector2
var _speed: float = 100
var direction = Vector2.RIGHT

func collect(kala : Kala) -> bool:
	if not super.collect(kala):
		return false
		
	GameManager.add_score(_score)
		
	return true

func _ready() -> void:
	_path_follower = get_parent() as PathFollower
	prev_pos = global_position
	
func _process(delta: float) -> void:
	if _path_follower != null:
		$AnimatedSprite2D.flip_h = _path_follower.direction < 0
		var movement = global_position - prev_pos

		if movement.length() > 0.001:
			$AnimatedSprite2D.flip_v = movement.y > 0
			
	else:
		position += direction * _speed * delta
		

	prev_pos = global_position
