# attack_state.gd

extends BossOneState

class_name BossOneAttackState

func _ready():

	animation_player.play("attack")
	
func out_of_range(_param):
	persistent_state.change_state("chase")
	
func _physics_process(_delta):
	moveHandler()

func moveHandler():
	pass

func attackHandler(_param):
	persistent_state.target.hp -= persistent_state.atk
