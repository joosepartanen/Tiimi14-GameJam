extends Area2D
class_name Collectable 

var is_collected : bool = false #kertoo onko kerätty jo vai ei

func _on_body_entered(body: Node2D) -> void:
	#print("Something collided with a collectable")
	if body is Kala:
		if not collect(body as Kala):
			print("Collecting didn't succeed")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func collect(_kala : Kala) -> bool:
	if is_collected:
		#On jo kerätty
		return false
	#TODO: Toista keräämiseen liittyvät efektit, kuten ääni ja partikkelit
	#Merkitään kerätyksi ja poistetaan
	is_collected = true
	queue_free()
	return true
