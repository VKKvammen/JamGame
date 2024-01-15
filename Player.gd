extends CharacterBody2D

# Constants for configuration.
const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const JUMP_COUNT = 2
const SHIELD_DURATION = 500
const SHIELD_COOLDOWN_TIME = 1000
const GROUND_GRIP = 0.8
const GROUND_MAX_SPEED = 400
const AIR_GRIP = 0.1
const AIR_MAX_SPEED = 600

# State variables.
var jumps = JUMP_COUNT
var shield = 0
var shieldCd = 0
var shieldNode

# Gravity setting.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	shieldNode = get_node("/root/Game/Player/Sprite/Shield")

func _physics_process(delta):
	process_gravity(delta)
	process_input(delta)
	process_movement(delta)
	update_shield_state(delta)

func process_gravity(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	elif jumps < JUMP_COUNT:
		jumps = JUMP_COUNT

func process_input(delta):
	if Input.is_action_just_pressed("ui_accept") and can_jump():
		perform_jump()

	if Input.is_action_just_pressed("ui_down") and shieldCd <= 0:
		activate_shield()

func can_jump() -> bool:
	return is_on_floor() or jumps > 0

func perform_jump():
	velocity.y = JUMP_VELOCITY
	jumps -= 1

func activate_shield():
	shield = SHIELD_DURATION
	shieldCd = SHIELD_COOLDOWN_TIME
	shieldNode.visible = true

func process_movement(delta):
	var direction = Input.get_axis("ui_left", "ui_right")
	var grip
	var max_speed
	match is_on_floor():
		true:
			grip = GROUND_GRIP
			max_speed = GROUND_MAX_SPEED
		false:
			grip = AIR_GRIP
			max_speed = AIR_MAX_SPEED

	if direction != 0:
		if velocity.x == 0:
			velocity.x = direction * grip * max_speed * delta * 10
		else:
			velocity.x += grip * (max_speed * direction - velocity.x) * delta * 10
	elif is_on_floor():
		velocity.x = move_toward(velocity.x, 0, SPEED)

	if shield > 0:
		move_with_shield(delta)
	else:
		move_and_slide()

func move_with_shield(delta):
	if !is_on_floor():
		var collision_info = move_and_collide(velocity * delta)
		if collision_info:
			velocity = velocity.bounce(collision_info.get_normal())
		return
	move_and_slide()
		
func update_shield_state(delta):
	shield -= delta * 1000
	if shield <= 0 and shieldNode.visible:
		shieldNode.visible = false
	shieldCd -= delta * 1000
