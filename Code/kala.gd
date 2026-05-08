extends CharacterBody2D
class_name Kala

@export var speed: float = 120.0
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var health: Health = $Health
#@onready var damage_timer: Timer = $DamageTimer
#@export var _damage_time : float = 1
@export var dash_speed: float = 400.0
@export var dash_time: float = 0.2
@export var dash_cooldown: float = 0.5

var is_dashing = false
var dash_timer = 0.0
var cooldown_timer = 0.0

var direction: Vector2 = Vector2.RIGHT  #Oletuksena liike lähtee oikealle

func _ready():
	GameManager.score_changed.connect(_on_score_changed)

func _on_score_changed(score):
	if score == 30:
		$AnimatedSprite2D.sprite_frames = load("res://Art/Kala2.tres")
		health.set_max_health(5)
		health.set_current_health(5)
		health.heal(5)
	elif score == 100:
		$AnimatedSprite2D.sprite_frames = load("res://Art/Kala3.tres")
		speed = 200.0
	elif score == 200:
		pass

func _physics_process(delta):
	handle_dash(delta)
	if not is_dashing:
		handle_input()
	if is_dashing:
		velocity = direction * dash_speed
	else:
		velocity = direction * speed
	move_and_slide()
	
	#Osuessaan tason reunoihin, kala kääntyy ympäri:
	if global_position.x <= 0:
		direction.x = 1
		$AnimatedSprite2D.flip_h = false
	elif global_position.x >= 1150:
		direction.x = -1
		$AnimatedSprite2D.flip_h = true
	elif global_position.y <= 0:
		direction.y = 1
		$AnimatedSprite2D.rotation_degrees = 90
	elif global_position.y >= 640:
		direction.y = -1
		$AnimatedSprite2D.rotation_degrees = -90

#Liike WASD ja Dash = Space
func handle_input():
	if Input.is_action_just_pressed("MoveLeft"):
		direction = Vector2.LEFT
		$AnimatedSprite2D.rotation_degrees = 0
		$AnimatedSprite2D.flip_h = true
		$AnimatedSprite2D.play("swim")
	elif Input.is_action_just_pressed("MoveRight"):
		direction = Vector2.RIGHT
		$AnimatedSprite2D.rotation_degrees = 0
		animated_sprite_2d.play("swim")
		$AnimatedSprite2D.flip_h = false
	elif Input.is_action_just_pressed("MoveUp"):
		direction = Vector2.UP    
		#$AnimatedSprite2D.sprite_frames = load("res://Art/Kalakokeilu.tres")
		$AnimatedSprite2D.flip_h = false
		$AnimatedSprite2D.rotation_degrees = -90
		$AnimatedSprite2D.play("swim")
	elif Input.is_action_just_pressed("MoveDown"):
		direction = Vector2.DOWN
		$AnimatedSprite2D.flip_h = false
		$AnimatedSprite2D.rotation_degrees = 90
		$AnimatedSprite2D.play("swim")
	elif Input.is_action_just_pressed("Dash"):
		#$AnimatedSprite2D.play("eat")
		pass
		
func handle_dash(delta):
	if cooldown_timer > 0:
		cooldown_timer -= delta

	if is_dashing:
		dash_timer -= delta
		if dash_timer <= 0:
			is_dashing = false
			cooldown_timer = dash_cooldown
	else:
		if Input.is_action_just_pressed("Dash") and cooldown_timer <= 0:
			is_dashing = true
			dash_timer = dash_time
			
func _on_health_changed(previous_health: int, current_health: int) -> void:
	if current_health <= 0:
		_die()
	elif current_health < previous_health:
		# Heath is reduced
		#health.is_immortal = true
		#damage_timer.start(_damage_time)
		#damage_timer.timeout.connect(_on_timer_timeout)
		#print(current_health)
		pass
		
func _die() -> void:
	get_tree().reload_current_scene.call_deferred()
	
func _on_timer_timeout() -> void:
	#damage_timer.timeout.disconnect(_on_timer_timeout)
	health.is_immortal = false
	
func bounce(bounce_force: Vector2) -> void:
	velocity += bounce_force
