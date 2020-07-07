extends Resource

export(String) var item_name
export(int) var physical_atk
export(int) var physical_def
export(int) var magic_atk
export(int) var magic_def
export(int) var knockback
export(String)var magic_type
export(int) var physical_pen
export(int) var magic_pen
export(int) var price
 
func _init(p_item_name = [], p_physical_atk = 0, p_physical_def = 0, p_magic_atk = 0, p_magic_def = 0, p_knockback = 0, p_magic_type = [], p_physical_pen = 0, p_magic_pen = 0, p_price = 0):
	item_name = p_item_name
	physical_atk = p_physical_atk
	physical_def = p_physical_def
	magic_atk = p_magic_atk
	magic_def = p_magic_def
	knockback = p_knockback
	magic_type = p_magic_type
	physical_pen = p_physical_pen
	magic_pen = p_magic_pen
	price = p_price
