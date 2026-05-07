extends Area2D
class_name Vihu

@onready var health: Health = $Health
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var damage_timer: Timer = $DamageTimer

@export var bounce_force: float = -200
@export var damage_time: float = 1

var path_follower : PathFollower = null

func _ready() -> void:
	path_follower = get_parent() as PathFollower
	#$AnimatedSprite2D.flip_v = true
	
func _process(_delta: float) -> void:
	if path_follower != null:
		animated_sprite_2d.flip_h = path_follower.direction < 0
		animated_sprite_2d.flip_v = global_transform.y.y < 0
		

func _on_take_damage(body: Node2D) -> void:
	if body is Kala:
		var kala : Kala = body as Kala
		# When the knight is immortal, it has just taken damage.
		# To prevent player from misusing this, prevent damaging enemy
		# during this time.
		if kala.health.is_immortal:
			return
		
		# Take damage
		health.take_damage(1)
		if health.get_current_health() == 0:
			_die()
		var bounce_vector: Vector2 = Vector2(0, bounce_force)
		kala.bounce(bounce_vector)


func _on_health_changed(previous_health: int, current_health: int) -> void:
	if current_health == 0:
		_die()
	if current_health < previous_health:
		# Start damage timer
		damage_timer.start(damage_time)
		damage_timer.timeout.connect(_on_timer_timeout)
		health.is_immortal = true
		animated_sprite_2d.play("damage")
		print(current_health, "vihu")

func _on_timer_timeout() -> void:
	damage_timer.timeout.disconnect(_on_timer_timeout)
	health.is_immortal = false
	animated_sprite_2d.play("default")

func _die() -> void:
	# TODO: Play animation, sound etc.
	queue_free()

func _on_damage_other(body: Node2D) -> void:
	if body is Kala:
		var kala : Kala = body as Kala
		if kala.health.is_immortal:
			return
		
		kala.health.take_damage(1)
		
		var bounce_vector: Vector2 = Vector2(0, bounce_force)
		kala.bounce(bounce_vector)
		
