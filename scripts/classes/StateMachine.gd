extends Node
class_name StateMachine

#Original code found on GameEndeavor's YouTube Video on State Machines. If you want a better explanation of this code, watch his videos.
#Comments by GravityI

var state = null setget set_state
var previous_state = null

onready var parent = get_parent()

func _physics_process(delta):
	_state_logic(delta)
	var transition = _get_transition(delta)
	if transition != null:
		set_state(transition)

func _state_logic(delta):
	pass

func _get_transition(delta):
	return null

func _enter_state(new_state, old_state):
	pass

func _exit_state(old_state, new_state):
	pass

func set_state(new_state):
	previous_state = state
	state = new_state
	
	if previous_state != null:
		_exit_state(previous_state, new_state)
	if new_state != null:
		_enter_state(new_state, previous_state)


#This isn't part of the original State Machine code. They're my personal additions to facilitate working with _animatedSprite  s and timing.

var animatedSprite  = null
var currentAnimation = null setget set_animation
var lastFrame = null

func set_animation_sprite(sprite):
	animatedSprite  = sprite

func get_animation_sprite():
	return animatedSprite 

func set_animation(animation):
	if animatedSprite .frames.has_animation(animation):
		currentAnimation = animation
		lastFrame = animatedSprite .frames.get_frame_count(animation) - 1
	return null

#Abstract Method for executing code on a determined animation frame
func onAnimationFrame(frame, delta):
	pass
#	match currentAnimation:
#		"default":
#			match frame:
#				0:
#					pass
#				lastFrame:
#					pass
	
