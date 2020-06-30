extends Control

func _ready():
	$Scroll/CharFrame/Sprite/AnimationPlayer.play("idle")


func _on_RollButton_pressed():
	var statArray = roll_stats()
	
	$Scroll/StatBlock/HpAmnt.set_text(str(statArray[0]))
	$Scroll/StatBlock/AtkAmnt.set_text(str(statArray[1]))
	$Scroll/StatBlock/DefAmnt.set_text(str(statArray[2]))
	$Scroll/StatBlock/IntAmnt.set_text(str(statArray[3]))
	$Scroll/StatBlock/SpdAmnt.set_text(str(statArray[4]))
	$Scroll/StatBlock/StamAmnt.set_text(str(statArray[5]))
	
	
func roll_stats():
	var stats = []
	for i in 6:
		randomize()
		var num1 = randi() % 6 + 1
		randomize()
		var num2 = randi() % 6 + 1
		randomize()
		var num3 = randi() % 6 + 1
		randomize()
		var num4 = randi() % 6 + 1
		var stat = [num1, num2, num3, num4]
		stat.sort()
		stat.remove(0)
		var stats_added = stat[0] + stat[1] + stat[2]
		stats.push_back(stats_added)
	return stats
		
