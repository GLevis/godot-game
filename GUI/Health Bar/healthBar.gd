extends Control

onready var healthBar = $Healthbar

func onHealthUpdated(health, amount):
	healthBar.value = health

func onMaxHealthUpdated(maxHealth):
	healthBar.maxValue = maxHealth
