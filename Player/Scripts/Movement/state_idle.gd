# idle_state.gd

extends PlayerState

class_name IdleState

func _ready():
	animated_sprite.play("idle")

func _process(_delta):
	inputHandler()

func inputHandler():
	if Input.is_action_pressed("move_left"):
		change_state.call_func("run")
	elif Input.is_action_pressed("move_right"):
		change_state.call_func("run")
		
	if Input.is_action_pressed("move_up"):
		change_state.call_func("run")
	elif Input.is_action_pressed("move_down"):
		change_state.call_func("run")
	
	if Input.is_action_just_pressed("left_attack"):
		change_state.call_func("magic")
	
