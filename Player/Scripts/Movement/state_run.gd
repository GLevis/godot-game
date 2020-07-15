# state_run.gd

extends State

class_name RunState

var move_speed = Vector2(200, 200)
var min_move_speed = 0.005
var friction = 0.32

var playerSpeed = ""

func _ready():
	pass


func _physics_process(_delta):
	
	if Input.is_action_pressed("sprint"):
		move_speed = Vector2(300, 300)
		playerSpeed = "run_"
	else:
		move_speed = Vector2(200, 200)
		playerSpeed = "walk_"
		
	if Input.is_action_pressed("move_left"):
		# if statement to make moving diagonally without sprite freezing
		if !Input.is_action_pressed("move_up") && !Input.is_action_pressed("move_down"):
			animation_player.play(playerSpeed + "left")
		persistent_state.velocity.x -= move_speed.x
		
	elif Input.is_action_pressed("move_right"):
		if !Input.is_action_pressed("move_up") && !Input.is_action_pressed("move_down"):
			animation_player.play(playerSpeed + "right")
		persistent_state.velocity.x += move_speed.x
		
		
	if Input.is_action_pressed("move_up"):
		persistent_state.velocity.y -= move_speed.y
		animation_player.play(playerSpeed + "up")
		
	elif Input.is_action_pressed("move_down"):
		persistent_state.velocity.y += move_speed.y
		animation_player.play(playerSpeed + "down")
	
	if abs(persistent_state.velocity.x) < min_move_speed && abs(persistent_state.velocity.y) < min_move_speed:
		change_state.call_func("idle")
	persistent_state.velocity.x *= friction
	persistent_state.velocity.y *= friction
