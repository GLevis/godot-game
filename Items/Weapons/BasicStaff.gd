extends BaseWeapon

onready var fireball_scene = preload("res://Items/Spells/Fireball.tscn")

const Stats = preload("base_weapon_stats.gd")

var stats
var fireball
var fireball_cd = Timer.new()
var canAttack = true
onready var sprite = $Staff

func _init(p_item_name = "", p_physical_atk = 0, p_physical_def = 0, p_magic_atk = 0, p_magic_def = 0, p_knockback = 0, p_magic_type = [], p_physical_pen = 0, p_magic_pen = 0, p_price = 0):
	self.stats = Stats.new(p_item_name, p_physical_atk, p_physical_def, p_magic_atk, p_magic_def, p_knockback, p_magic_type, p_physical_pen, p_magic_pen, p_price)
	fireball_cd.connect("timeout", self, "cool_down")
	add_child(fireball_cd)


func left_click():
	if canAttack == true:
		fireball = fireball_scene.instance()
		get_parent().get_node("RotationAxis").rotation = get_angle_to(get_global_mouse_position())
		fireball.position = get_parent().get_node("RotationAxis/ProjectileSpawnPoint").get_position()
		fireball.rotation = get_angle_to(get_global_mouse_position())
		add_child(fireball)
		canAttack = false
		fireball_cd.start()


func right_click():
	pass


func q_click():
	pass


func cool_down():
	canAttack = true
