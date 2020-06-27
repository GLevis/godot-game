# run_state.gd

extends MeleeEnemyState

class_name MeleeChaseState


func _ready():
	# animated_sprite.play("run")
	persistent_state.detection.connect("body_exited", self, "no_chase")


func no_chase(_param):
	persistent_state.player_detected = false
	persistent_state.change_state("idle")
	persistent_state.dir = Vector2.ZERO
	
	
func _physics_process(_delta):
	persistent_state.velocity = persistent_state.dir * persistent_state.speed

func moveHandler():
	if persistent_state.player_detected:
		var look = persistent_state.get_node("RayCast2D")
		look.cast_to = (persistent_state.target.position - persistent_state.position)
		look.force_raycast_update()
		
		if !look.is_colliding():
			persistent_state.dir = look.cast_to.normalized()
		else:
			for scent in persistent_state.target.scent_trail:
				look.cast_to = scent.position - persistent_state.position
				look.force_raycast_update()
				
				if !look.is_colliding():
					persistent_state.dir = look.cast_to.normalized()
					break
	else:
		persistent_state.change_state("idle")
