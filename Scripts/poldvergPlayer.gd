extends CharacterBody2D
@onready var coyote_timer = $CoyoteTimer
@onready var animated_sprite = $AnimatedSprite2D
@onready var animation_player = $AnimationPlayer

var infinite_jump = false
var dead = false
var coyote_frames = 10  # How many in-air frames to allow jumping
var coyote = false  # Track whether we're in coyote time or not
var last_floor = false  # Last frame's on-floor state

const SPEED = 105.0
const JUMP_VELOCITY = -200.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	coyote_timer.wait_time = coyote_frames / 60.0
	
func _physics_process(delta):
#	if dead:
#		return 
		# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Coyote Time
	if is_on_floor():
		last_floor = true
	elif last_floor:
		last_floor = false
		coyote = true
		coyote_timer.start()

	# Handle Jump.
	if Input.is_action_just_pressed("jump") and (is_on_floor() or coyote):
		velocity.y = JUMP_VELOCITY
		if infinite_jump==true:
			coyote = true
		else:
			coyote = false
			coyote_timer.stop()

	var direction = Input.get_axis("move_left", "move_right")
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
	
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("Idle")
		else:
			animated_sprite.play("run")
	else:
		animated_sprite.play("jump")

	if direction:
		velocity.x = direction * SPEED * delta * 60
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	move_and_slide()

func _on_coyote_timer_timeout():
	if infinite_jump==true:
		coyote_frames = 100000.0
		coyote = true
		coyote_timer.wait_time = 20
	else:
		coyote = false
	
func set_infinite_jump(value):
	infinite_jump = value
	print("Бесконечный прыжок установлен: ", value)
	
func die():
	if not dead:
		dead = true
		animated_sprite.play("dead")
		animation_player.play("Dead")
		set_physics_process(false)
	print("Игрок умер")

	
