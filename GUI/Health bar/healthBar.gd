extends Control

onready var healthBar = $HealthBar

func onHealthUpdated(health, amount):
	healthBar.value = health

func onMaxHealthUpdated(maxHealth):
	healthBar.max_value = maxHealth
	
