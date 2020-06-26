# idle_state.gd

extends State

class_name IdleState

func _ready():
	animated_sprite.play("idle")


func inputHandler():
	if Input.is_action_pressed("move_left"):
		change_state.call_func("run")
	elif Input.is_action_pressed("move_right"):
		change_state.call_func("run")
		
	if Input.is_action_pressed("move_up"):
		change_state.call_func("run")
	elif Input.is_action_pressed("move_down"):
		change_state.call_func("run")
