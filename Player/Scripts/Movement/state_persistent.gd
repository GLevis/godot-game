# state_persistent.gd

extends KinematicBody2D

class_name PersistentState

const scent_scene = preload("res://Player/Scenes/scent.tscn")
const weapon_scene = preload("res://Items/Weapons/BasicStaff.tscn")

var state
var state_factory
var scent_trail = []
var current_weapon
var current_mouse_pos
var fireball

var velocity = Vector2()

var hp = 20
var prevHp = hp

func _ready():
	state_factory = PlayerStateFactory.new()
	$ScentTimer.connect("timeout", self, "add_scent")
	change_state("idle")
	current_weapon = weapon_scene.instance()
	current_weapon._init("Basic Staff", 1, 0, 0, 0, 1, null, 0, 0, 1)
	add_child(current_weapon)
	print(current_weapon.stats.item_name)


func add_scent():
	var scent = scent_scene.instance()
	scent.player = self
	scent.position = self.position
	scent_trail.push_front(scent)


func _process(_delta):
	if prevHp > hp:
		print(hp)
		prevHp = hp
	if Input.is_action_just_pressed("left_attack"):
		current_weapon.left_click()

func change_state(new_state_name):
	if state != null:
		state.queue_free()
	state = state_factory.get_state(new_state_name).new()
	state.setup(funcref(self, "change_state"), $AnimatedSprite, self)
	state.name = "current_state"
	add_child(state)
