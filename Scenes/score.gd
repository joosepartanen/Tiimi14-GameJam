extends Label

#@export var _score: int = 0

func _ready():
	GameManager.score_changed.connect(_on_score_changed)

func _on_score_changed(new_score: int) -> void:
	text = "Score: %s" % new_score
