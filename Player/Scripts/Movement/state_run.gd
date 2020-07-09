# state_run.gd

extends State

class_name RunState

var move_speed = Vector2(100, 100)
var min_move_speed = 0.005
var friction = 0.32

func _ready():
	animation_player.play("run")


func _physics_process(_delta):
	if Input.is_action_pressed("move_left"):
		persistent_state.velocity.x -= move_speed.x
		animation_player.flip_h = true
		persistent_state.current_weapon.flipped = true
	elif Input.is_action_pressed("move_right"):
		animation_player.flip_h = false
		persistent_state.current_weapon.flipped = false
		persistent_state.velocity.x += move_speed.x
		
	if Input.is_action_pressed("move_up"):
		persistent_state.velocity.y -= move_speed.y
	elif Input.is_action_pressed("move_down"):
		persistent_state.velocity.y += move_speed.y
	
	if Input.is_action_pressed("sprint"):
		move_speed = Vector2(250, 250)
	else:
		move_speed = Vector2(100, 100)
	
	if abs(persistent_state.velocity.x) < min_move_speed && abs(persistent_state.velocity.y) < min_move_speed:
		change_state.call_func("idle")
	persistent_state.velocity.x *= friction
	persistent_state.velocity.y *= friction
