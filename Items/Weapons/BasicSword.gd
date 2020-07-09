extends BaseWeapon

const Stats = preload("base_weapon_stats.gd")

var stats

var combo = 0
var timer = Timer.new()

onready var sprite = $Sword

func _init(p_item_name = "", p_physical_atk = 0, p_physical_def = 0, p_magic_atk = 0, p_magic_def = 0, p_knockback = 0, p_magic_type = [], p_physical_pen = 0, p_magic_pen = 0, p_price = 0):
	self.stats = Stats.new(p_item_name, p_physical_atk, p_physical_def, p_magic_atk, p_magic_def, p_knockback, p_magic_type, p_physical_pen, p_magic_pen, p_price)
	timer.connect("timeout", self, "timeout")
	add_child(timer)


func left_click():
	timer.stop()
	combo += 1
	if flipped == false:
		if combo == 1:
			$AnimationPlayer.play("sword_chain1_right")
		if combo == 2:
			$AnimationPlayer.play("sword_chain2_right")
		if combo == 3:
			$AnimationPlayer.play("sword_chain3_right")
			combo = 0
	else:
		if combo == 1:
			$AnimationPlayer.play("sword_chain1_left")
		if combo == 2:
			$AnimationPlayer.play("sword_chain2_left")
		if combo == 3:
			$AnimationPlayer.play("sword_chain3_left")
			combo = 0
		
	timer.start()

func timeout():
	if flipped == false:
		$AnimationPlayer.play("idle")
	else:
		$AnimationPlayer.play("idle_flipped")
	combo = 0
	print("timeout")

func right_click():
	pass


func q_click():
	pass



