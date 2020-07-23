# state_persistent.gd

extends KinematicBody2D

class_name PersistentState

const scent_scene = preload("res://Player/Scenes/scent.tscn")
const weapon_scene = preload("res://Items/Weapons/BasicStaff.tscn")
const inventory_scene = preload("res://GUI/Inventory/New Inv/Inventory.tscn")

var state
var state_factory
var scent_trail = []
var current_weapon
var current_mouse_pos
var fireball
var direction = "down"

var velocity = Vector2()

var max_hp = 20
var hp = 20
var prevHp = hp

var inventory = inventory_scene.instance()
var inventoryToggled = false

onready var health_bar = get_node("CanvasLayer/HUDbars/Bars/HealthBar")

func _ready():
	state_factory = PlayerStateFactory.new()
	$ScentTimer.connect("timeout", self, "add_scent")
	change_state("idle")
	current_weapon = weapon_scene.instance()
	current_weapon._init("Basic Staff", 1, 0, 0, 0, 1, null, 0, 0, 1)
	add_child(current_weapon)


func add_scent():
	var scent = scent_scene.instance()
	scent.player = self
	scent.position = self.position
	scent_trail.push_front(scent)


func _process(_delta):
	if prevHp > hp:
		prevHp = hp
	if Input.is_action_just_pressed("left_attack"):
		current_weapon.left_click()
	if Input.is_action_just_pressed("inventory"):
		if inventoryToggled == false:
			$CanvasLayer.add_child(inventory)
			inventoryToggled = true
		elif inventoryToggled == true:
			$CanvasLayer.remove_child(inventory)
			inventoryToggled = false
	health_bar.value = ( health_bar.max_value * hp ) / max_hp

func change_state(new_state_name):
	if state != null:
		state.queue_free()
	state = state_factory.get_state(new_state_name).new()
	state.setup(funcref(self, "change_state"), $AnimationPlayer, self)
	state.name = "current_state"
	add_child(state)
