# run_state.gd

extends State

class_name MeleeIdleState


 
func _ready():
	animation_player.play("idle")
	persistent_state.detection.connect("body_entered", self, "detected")
	persistent_state.direction_timer.connect("timeout", self, "change_direction")
	persistent_state.direction_timer.start()
	persistent_state.player_detected = false
	persistent_state.hitstun = false

func detected(_param):
	for body in persistent_state.detection.get_overlapping_bodies():
		if body.name == "Player" || body.name == "Fireball":
			if body.name == "Fireball":
				var body1 = body.get_parent()
				var body2 = body1.get_parent()
				persistent_state.target = body2
				persistent_state.player_detected = true
			elif body.name == "Player":
				persistent_state.target = body
				persistent_state.player_detected = true


func change_direction():
	if persistent_state.direction.randi_range(1,2) == 1:
		persistent_state.velocity = Vector2.ZERO
	else:
		randomize()
		var x = persistent_state.direction.randf_range(-1, 1)
		randomize()
		var y = persistent_state.direction.randf_range(-1, 1)
		persistent_state.velocity = Vector2(x, y) * persistent_state.idle_speed


func _physics_process(_delta):
	moveHandler()


func moveHandler():
	if persistent_state.player_detected == true:
		change_state.call_func("chase")

