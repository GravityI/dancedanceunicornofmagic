extends StateMachine

enum states {IDLE, WALK, CARRY}

var horizontal = 0
var vertical = 0
var motion = Vector2()
var carrying = false

onready var sprite = $"../PlayerBody/YSort/Sprite"
onready var player = $"../PlayerBody"

func _ready():
	globals.score = 0
	call_deferred("set_state", states.IDLE)
	set_animation_sprite(sprite)

func twoAxisInput():
	if Input.is_action_just_pressed("ui_up"):
		vertical -= 1
	if Input.is_action_just_pressed("ui_down"):
		vertical += 1
	if Input.is_action_just_pressed("ui_left"):
		horizontal -= 1
	if Input.is_action_just_pressed("ui_right"):
		horizontal += 1

	if Input.is_action_just_released("ui_up"):
		vertical += 1
	if Input.is_action_just_released("ui_down"):
		vertical -= 1
	if Input.is_action_just_released("ui_left"):
		horizontal += 1
	if Input.is_action_just_released("ui_right"):
		horizontal -= 1

	if !(Input.is_action_pressed("ui_up") or Input.is_action_pressed("ui_down")):
		vertical = 0
	if !(Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right")):
		horizontal = 0
		
	motion = Vector2(horizontal, vertical).normalized()

func _state_logic(delta):
	twoAxisInput()
	if player.get_global_mouse_position().x > player.global_position.x:
		sprite.flip_h = true
	else:
		sprite.flip_h = false

func _get_transition(delta):
	match state:
		states.IDLE:
			if motion != Vector2():
				return states.WALK
		states.WALK:
			if  motion == Vector2():
				return states.IDLE

func _enter_state(new_state, old_state):
	match new_state:
		states.IDLE:
			sprite.animation = "idle"
		states.WALK:
			sprite.animation = "walk"
