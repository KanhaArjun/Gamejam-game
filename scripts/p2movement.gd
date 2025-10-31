extends CharacterBody2D

const SPEED = 60.0
const TURN_ACCELERATION = 1100.0
const ROLL_SPEED = 250.0

var is_dying = false

const JUMP_SPEED = 140.0 
const JUMP_DURATION = 0.15
const MAX_FALL_SPEED = 500.0 
const MAX_JUMPS = 2

@onready var Anim = $AnimatedSprite2D
@onready var roll_cooldown_timer = $Timer

var gravity = 980
var direction_stack = []
var is_rolling = false
var current_roll_direction = 0

var is_jumping = false 
var jump_time_elapsed = 0.0 
var jumps_remaining = MAX_JUMPS

func _input(event):
	var is_left = event.is_action("ui_left")
	var is_right = event.is_action("ui_right")

	if not is_left and not is_right:
		return

	var direction_value = 1 if is_right else -1

	if event.is_pressed():
		if not direction_value in direction_stack:
			direction_stack.push_back(direction_value)
	
	if event.is_released():
		direction_stack.erase(direction_value)

func _ready():
	if(GlobalStuff.total_deaths>5):
		spawnnew()
		
func _physics_process(delta):
	
	if is_on_floor():
		jumps_remaining = MAX_JUMPS
	
	if not is_jumping:
		velocity.y += gravity * delta

	if Input.is_action_just_pressed("up_key"):
		if is_on_floor() or jumps_remaining > 0:
			
			if not is_on_floor():
				jumps_remaining -= 1
			
			is_jumping = true
			jump_time_elapsed = 0.0
			
			if is_on_floor():
				jumps_remaining = MAX_JUMPS - 1

	
	if Input.is_action_just_released("up_key"):
		is_jumping = false
		
	if is_jumping:
		if jump_time_elapsed < JUMP_DURATION:
			velocity.y = -JUMP_SPEED 
			jump_time_elapsed += delta
		else:
			is_jumping = false
			
	velocity.y = min(velocity.y, MAX_FALL_SPEED)
	
	var direction = direction_stack.back() if not direction_stack.is_empty() else 0

	if is_rolling:
		if Input.is_action_just_pressed("up_key"): 
			is_rolling = false
			
			if not is_on_floor():
				jumps_remaining -= 1
			
			if is_on_floor() or jumps_remaining >= 0:
				is_jumping = true 
				jump_time_elapsed = 0.0
				if is_on_floor():
					jumps_remaining = MAX_JUMPS - 1
			else:
				is_jumping = false
				
		if direction != 0 and direction == -current_roll_direction:
			is_rolling = false
			velocity.x = direction * SPEED
	else:
		if direction:
			if direction * velocity.x < 0:
				velocity.x = move_toward(velocity.x, direction * SPEED, TURN_ACCELERATION * delta)
			else:
				velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, TURN_ACCELERATION * delta)
		
		if Input.is_action_just_pressed("dodge_roll") and roll_cooldown_timer.is_stopped():
			is_rolling = true
			is_jumping = false 
			current_roll_direction = 1 if not Anim.flip_h else -1
			velocity.x = current_roll_direction * ROLL_SPEED
			if is_on_floor():
				velocity.y = 0
			Anim.play("roll")
			roll_cooldown_timer.start()

	if direction == -1:
		Anim.flip_h = true
	elif direction == 1:
		Anim.flip_h = false
	
	if is_dying:
		velocity.x=0
		Anim.play("death")
	elif is_rolling:
		if Anim.animation != "roll":
			Anim.play("roll")
	else:
		if not is_on_floor(): 
			Anim.play("Jump")
		else:
			if direction:
				Anim.play("run")
			else:
				Anim.play("idle")

	move_and_slide()

func _on_animated_sprite_2d_animation_finished():
	if Anim.animation == "roll":
		is_rolling = false
		velocity.x = 0

func spawnnew():
	position.x=560
	position.y=-124

func spawnStart():
	position.x=-734
	position.y=-123

func death():
	GlobalStuff.add_deaths()
	is_dying = true
