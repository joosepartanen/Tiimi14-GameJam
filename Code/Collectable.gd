extends Area2D
class_name Collectable 

var is_collected : bool = false #kertoo onko kerätty jo vai ei

func _on_body_entered(body: Node2D) -> void:
	if body is Kala:
		if not collect(body as Kala):
			print("Collecting didn't succeed")

func _ready() -> void:
	pass

func collect(_kala : Kala) -> bool:
	if is_collected:
		#On jo kerätty
		return false
	is_collected = true
	queue_free()
	return true
