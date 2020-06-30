# run_state.gd

extends PlayerState

class_name RunState

var move_speed = Vector2(180, 180)
var min_move_speed = 0.005
var friction = 0.32

func _ready():
	animated_sprite.play("run")


func _physics_process(_delta):
	inputHandler()


func inputHandler():
	
	if Input.is_action_pressed("move_left"):
		persistent_state.velocity.x -= move_speed.x
		animated_sprite.flip_h = true
		persistent_state.melee_weapon.scale = Vector2(-1, 1)
	elif Input.is_action_pressed("move_right"):
		animated_sprite.flip_h = false
		persistent_state.velocity.x += move_speed.x
		persistent_state.melee_weapon.scale = Vector2(1, 1)
		
	if Input.is_action_pressed("move_up"):
		persistent_state.velocity.y -= move_speed.y
	elif Input.is_action_pressed("move_down"):
		persistent_state.velocity.y += move_speed.y
	
	if Input.is_action_pressed("sprint"):
		move_speed = Vector2(500, 500)
	else:
		move_speed = Vector2(300, 300)
	
		
	if Input.is_action_just_pressed("left_attack"):
		change_state.call_func("melee")
		
	if abs(persistent_state.velocity.x) < min_move_speed && abs(persistent_state.velocity.y) < min_move_speed:
		change_state.call_func("idle")
	persistent_state.velocity.x *= friction
	persistent_state.velocity.y *= friction

