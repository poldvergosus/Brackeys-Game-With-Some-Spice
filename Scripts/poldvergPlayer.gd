extends CharacterBody2D

@onready var game_manager = %GameManager
@onready var coyote_timer: Timer = $CoyoteTimer
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

@export var SPEED: float = 105.0
@export var JUMP_VELOCITY: float = -200.0
@export var COYOTE_FRAMES: int = 5

var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")
var infinite_jump: bool = false
var dead: bool = false
var coyote: bool = false
var last_floor: bool = false

func _ready():
	game_manager.update_death_label()
	coyote_timer.wait_time = COYOTE_FRAMES / 60.0

func _physics_process(delta):
	if dead:
		return

	apply_gravity(delta)
	handle_coyote_time()
	handle_jump()
	handle_movement(delta)
	update_animation()
	move_and_slide()

func apply_gravity(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

func handle_coyote_time():
	if is_on_floor():
		last_floor = true #указывает на то, что игрок был на земле в предыдущем кадре
	elif last_floor: #проверяет, был ли игрок на земле в предыдущем кадре
		last_floor = false
		coyote = true
		coyote_timer.start()

func handle_jump():
	if Input.is_action_just_pressed("jump") and (is_on_floor() or coyote):
		velocity.y = JUMP_VELOCITY
		if not infinite_jump:
			coyote = false
			coyote_timer.stop()

func handle_movement(delta):
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED * delta * 60
		animated_sprite.flip_h = direction < 0
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

func update_animation():
	if is_on_floor():
		animated_sprite.play("run" if velocity.x != 0 else "Idle")
	else:
		animated_sprite.play("jump")

func _on_coyote_timer_timeout():
	if infinite_jump:
		coyote_timer.wait_time = 20
	else:
		coyote = false

func set_infinite_jump(value: bool):
	infinite_jump = value
	print("Бесконечный прыжок установлен")

func die():
	if not dead:
		dead = true
		animated_sprite.play("dead")
		animation_player.play("Dead")
		game_manager.death_label_update()
		set_physics_process(false)
		print("Игрок умер")
