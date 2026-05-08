extends CharacterBody2D
class_name VihuS

@export var speed: float = 60.0
@export var detection_range: float = 700.0
@export var stop_range: float = 20.0
@export var rotation_speed: float = 5.0

var player: CharacterBody2D = null
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _ready():
	player = get_tree().get_first_node_in_group("player")

func _physics_process(delta):
	if player == null:
		return
	
	var direction_to_player = global_position.direction_to(player.global_position)
	var distance = global_position.distance_to(player.global_position)
	
	if distance < detection_range and distance > stop_range:
		velocity = direction_to_player * speed
		
		if velocity.length() > 0:
			var target_angle = velocity.angle()
			animated_sprite.rotation = lerp_angle(animated_sprite.rotation, target_angle, rotation_speed * delta)
			
	else:
		velocity = Vector2.ZERO
	
	move_and_slide()
	
	if velocity.length() > 0:
		animated_sprite.play("swim")
	else:
		animated_sprite.play("swim")
		
func _on_damage_other(body: Node2D) -> void:
	if body is Kala:
		var kala : Kala = body as Kala
		if kala.health.is_immortal:
			return
		
		kala.health.take_damage(5)
		
		
