# state_attack.gd

extends State

class_name BossOneAttackState

func _ready():
	persistent_state.attack_timer.connect("timeout", self, "attack1")
	persistent_state.detection.connect("body_exited", self, "out_of_range")
	
func out_of_range(_param):
	persistent_state.change_state("idle")
	
func _physics_process(_delta):
	moveHandler()

func moveHandler():
	pass
	
func attack1():
	var look = persistent_state.get_node("RayCast2D")
	var player_pos = persistent_state.target.position - persistent_state.position
	look.cast_to = (player_pos)
	look.force_raycast_update()
	
	var FireRings = persistent_state.FireRings_scene.instance()
	var FireMove = persistent_state.FireMove_scene.instance()
	FireRings.position = player_pos
	FireMove.position = player_pos
	persistent_state.add_child(FireRings)
	persistent_state.add_child(FireMove)
	FireRings.get_node("AnimationPlayer").play("Rings")
	FireMove.get_node("AnimationPlayer").play("Rings")
	if !FireRings.get_node("AnimationPlayer").is_playing():
		FireRings.queue_free()
		FireMove.queue_free()
	
	
