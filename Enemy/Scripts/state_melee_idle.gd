# run_state.gd

extends MeleeEnemyState

class_name MeleeIdleState

var direction = RandomNumberGenerator.new()

func _ready():
	animation_player.play("idle")
	persistent_state.detection.connect("body_entered", self, "detected")
	persistent_state.direction_timer.connect("timeout", self, "change_direction")
	persistent_state.player_detected = false


func detected(_param):
	for body in persistent_state.detection.get_overlapping_bodies():
			if body.name == "Player":
				persistent_state.target = body
				persistent_state.player_detected = true


func change_direction():
	randomize()
	if direction.randi_range(1,2) == 1:
		persistent_state.velocity = Vector2.ZERO
		print(direction.randi_range(1,2))
	else:
		randomize()
		var x = direction.randf_range(-1, 1)
		randomize()
		var y = direction.randf_range(-1, 1)
		persistent_state.velocity = Vector2(x, y) * persistent_state.idle_speed


func _physics_process(_delta):
	moveHandler()


func moveHandler():
	if persistent_state.player_detected == true:
		change_state.call_func("chase")

