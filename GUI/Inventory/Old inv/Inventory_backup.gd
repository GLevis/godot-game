extends Control

var inven_data 
signal inventory_full
signal item_picked_up
signal store_current_item(CurrentItem)

var CurrentItem = null
var SwitchItem = null
var ButtonNum = null
var IsHolding = false

var buttoncounter = 0



func _ready():
	for i in get_tree().get_nodes_in_group("ItemOnGround"):
		i.connect("player_in_range", self, "_on_Player_in_range")
		
	for i in get_tree().get_nodes_in_group("ItemButton"):
		i.connect("ButtonPressed", self, "_on_Button_pressed")
		i.connect("ReceivedItem", self, "_on_Item_received")
	
func _on_Player_in_range(ItemName):
	
	# loads the sprite for the item
	var item_texture = load("res://Sprites/" + str(ItemName) + ".png")
	var counter = 0
	
	# program will cycle through all inventory slots until it htis an empty one,
	# if it does not find one, it will emit a signal
	for i in get_tree().get_nodes_in_group("InventorySlot"):
		
		# TL;DR if the inventory slot it is currently on does not have a picture in it, make it have one
		if get_node(str(i.get_path()) + "/ItemBg/ItemButton" + str(counter)).get_normal_texture() == null:
			get_node(str(i.get_path()) + "/ItemBg/ItemButton" + str(counter)).set_normal_texture(item_texture)
			emit_signal("item_picked_up")
			break
		
		if get_node(str(i.get_path()) + "/ItemBg/ItemButton"+ str(counter)).get_normal_texture() != null && counter != 23:
			counter = counter + 1
			continue
			
		if counter == 23:
			emit_signal("inventory_full")
			
		counter = counter + 1
			
func _on_Button_pressed(image, ItemGiven):
	if !IsHolding:
		ButtonNum = str(image).right(10)
		CurrentItem = get_node("InventoryBackground/InventoryElements/VBoxContainer/MainElements/Items/ItemSlot" + ButtonNum + "/ItemBg/ItemButton" + ButtonNum)
		emit_signal("store_current_item", CurrentItem)
		IsHolding = true
		yield(CurrentItem, "ReceivedItem")

		
	if IsHolding:
		CurrentItem = ItemGiven
		var TempItem = ItemGiven
		print(TempItem)
		ButtonNum = str(image).right(10)
		SwitchItem = get_node("InventoryBackground/InventoryElements/VBoxContainer/MainElements/Items/ItemSlot" + ButtonNum + "/ItemBg/ItemButton" + ButtonNum)
		CurrentItem.set_normal_texture(SwitchItem.get_normal_texture())
		SwitchItem.set_normal_texture(TempItem.get_normal_texture())
		CurrentItem = null
		TempItem = null
		SwitchItem = null
		IsHolding = false
		

func _on_Item_received():
	# literally doesn't do anything, just here for more spaghetti :)
	pass

