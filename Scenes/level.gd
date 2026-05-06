extends Node2D
class_name Level

@onready var kala: Kala = $Kala
@onready var healthbar: Healthbar = $CanvasLayer/Healthbar
@onready var music_player: AudioStreamPlayer = $MusicPlayer


# Ritarin aloituspiste
var _spawn_point : Vector2 = Vector2.ZERO


func _ready() -> void:
	GameManager.register_current_level(self)
	healthbar.setup(kala.health)
	
	# Aseta ritarin aloituspiste
	_spawn_point = kala.global_position
	
	# Toista musiikki
	#music_player.play()

func respawn_knight() -> void:
	kala.global_position = _spawn_point
