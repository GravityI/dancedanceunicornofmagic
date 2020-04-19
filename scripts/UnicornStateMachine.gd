extends StateMachine

enum states {UPARMS, DOWNARMS, DEAD}

func _ready():
	call_deferred("set_state", states.UPARMS)
	set_animation_sprite($"../Sprite")

func _get_transition(delta):
	match state:
		states.UPARMS:
			if animation_in_last_frame() and !parent.carried:
				return states.DOWNARMS
		states.DOWNARMS:
			if animation_in_last_frame():
				return states.UPARMS
	return null

func _enter_state(new_state, old_state):
	match state:
		states.DEAD:
			set_animation("dead")
			animatedSprite.pause_mode = PAUSE_MODE_PROCESS
			get_tree().paused = true

func _exit_state(old_state, new_state):
	pass

func animation_frame_logic(delta):
	match currentAnimation:
		"dead":
			match animatedSprite.frame:
				lastFrame:
					yield(get_tree().create_timer(0.5), "timeout")
					get_tree().change_scene("res://scenes/game over.tscn")
	
