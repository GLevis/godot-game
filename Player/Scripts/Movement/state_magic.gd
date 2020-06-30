# state_melee_attack.gd

extends PlayerState

class_name MagicState

func _ready():
	var projectile = persistent_state.fireball_scene.instance()
	persistent_state.get_node("RotationAxis").rotation = get_angle_to(get_global_mouse_position())
	projectile.position = persistent_state.get_node("RotationAxis/ProjectileSpawnPoint").get_position()
	projectile.rotation = get_angle_to(get_global_mouse_position())
	persistent_state.add_child(projectile)
	change_state.call_func("run")

func _process(_delta):
	pass
