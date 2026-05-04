extends Collectable
class_name Saalis

@export var _score: int = 10

func collect(kala : Kala) -> bool:
	if not super.collect(kala):
		return false
		
	GameManager.add_score(_score)
		
	return true
