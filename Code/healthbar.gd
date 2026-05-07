extends HBoxContainer
class_name Healthbar

const Head = preload("uid://6v6clg0p3psa")

var _hearts : Array[Control] = []

func setup(health: Health) -> void:
	# Create as many hearts as the max health is
	for i in health.max_health:
		var heart : Control = Head.instantiate() as Control
		add_child(heart)
		_hearts.push_back(heart)
	
	health.health_changed.connect(_on_health_changed)
	_on_health_changed(health.max_health, health.max_health)

func _on_health_changed(_previous_health : int, current_health : int) -> void:
	for i in _hearts.size():
		_hearts[i].visible = i < current_health
