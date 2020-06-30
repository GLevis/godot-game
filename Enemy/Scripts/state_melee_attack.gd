# attack_state.gd

extends MeleeEnemyState

class_name MeleeAttackState

func _ready():

	animation_player.play("attack")
	persistent_state.inrange.connect("body_exited", self, "out_of_range")
	persistent_state.hitbox.connect("body_entered", self, "attackHandler")
	
func out_of_range(_param):
	persistent_state.change_state("chase")
	
func _physics_process(_delta):
	persistent_state.dir = Vector2.ZERO
	moveHandler()

func moveHandler():
	pass

func attackHandler(_param):
	persistent_state.target.hp -= persistent_state.atk
