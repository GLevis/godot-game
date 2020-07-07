extends BaseWeapon

const Stats = preload("base_weapon_stats.gd")

var stats

func _init(p_item_name = [], p_physical_atk = 0, p_physical_def = 0, p_magic_atk = 0, p_magic_def = 0, p_knockback = 0, p_magic_type = [], p_physical_pen = 0, p_magic_pen = 0, p_price = 0):
	self.stats = Stats.new(p_item_name, p_physical_atk, p_physical_def, p_magic_atk, p_magic_def, p_knockback, p_magic_type, p_physical_pen, p_magic_pen, p_price)

func left_click():
	pass

func right_click():
	pass

func q_click():
	pass



