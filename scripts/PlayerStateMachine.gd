extends StateMachine

enum states {IDLE, WALK, DEAD, CARRY}

var horizontal = 0
var vertical = 0
var motion = Vector2()
var moveSpeed = 10

onready var sprite = $"../PlayerBody/YSort/Sprite"

func _ready():
	globals.score = 0
	call_deferred("set_state", states.IDLE)
	set_animation_sprite(sprite)
	
func _process(delta):
	twoAxisInput()

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


func _enter_state(new_state, old_state):
	match new_state:
		states.IDLE:
			set_animation("idle")
		states.WALK:
			sprite.animation = "walk"
		states.DEAD:
			sprite.animation = "dead"
			sprite.pause_mode = PAUSE_MODE_PROCESS
			get_tree().paused = true
		states.CARRY:
			sprite.animation = "carry"
			$"../Unicorn".carried = true
			moveSpeed = 5

func _exit_state(old_state, new_state):
	match old_state:
		states.CARRY:
			$"../Unicorn".carried = false
			moveSpeed = 10

func onAnimationFrame(frame, delta):
	match currentAnimation:
		"dead":
			match frame:
				lastFrame:
					get_tree().change_scene("res://scenes/game over.tscn")
