# run_state.gd

extends MeleeEnemyState

class_name MeleeIdleState

func _ready():
	# animated_sprite.play("run")
	persistent_state.detection.connect("body_entered", self, "detected")
	persistent_state.player_detected = false


func detected(_param):
	for body in persistent_state.detection.get_overlapping_bodies():
			if body.name == "Player":
				persistent_state.target = body
				persistent_state.player_detected = true


func _physics_process(_delta):
	pass

func moveHandler():
	if persistent_state.player_detected == true:
		change_state.call_func("chase")
	
