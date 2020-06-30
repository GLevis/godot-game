extends Area2D

class_name ItemWeapon

var item_name
var type
var atk_melee
var def
var atk_magic
var def_magic
var knockback
var magic_type
var atk_melee_pen
var atk_magic_pen
var effect
var price

func _ready():
	self.connect("body_entered", self, "landed_hit")
	

func get_item_list(path):
	pass

func new_item(item_name, type, atk_melee, def, atk_magic, def_magic, knockback, magic_type, atk_melee_pen, atk_magic_pen, effect, price):
	self.item_name = item_name
	self.type = type
	self.atk_melee = atk_melee
	self.def = def
	self.atk_magic = atk_magic
	self.def_magic = def_magic
	self.knockback = knockback
	self.magic_type = magic_type
	self.atk_melee_pen = atk_melee_pen
	self.atk_magic_pen = atk_magic_pen
	self.effect = effect
	self.price = price


func attack1():
	$AnimationPlayer.play("sword_attack_left")


func landed_hit(_param):
	for body in get_overlapping_bodies():
		if body.name != "Player":
			body.hp -= atk_melee
			body.receiveKnockback(self)
