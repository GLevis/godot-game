# attack_state.gd

extends State

class_name MeleeAttackState

func _ready():
	animation_player.play("attack")
	persistent_state.inrange.connect("body_exited", self, "out_of_range")
	persistent_state.hitbox.connect("body_entered", self, "attackHandler")
	persistent_state.velocity = Vector2.ZERO
	
func out_of_range(_param):
	persistent_state.change_state("chase")
	
func _physics_process(_delta):
	moveHandler()

func moveHandler():
	pass

func attackHandler(_param):
	persistent_state.target.hp -= persistent_state.atk
