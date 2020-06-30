extends TextureButton

signal ButtonPressed(image, CurrentItem)
signal ReceivedItem
var CurrentItem = null

func _ready():
	get_tree().get_root().get_node("Inventory").connect("store_current_item", self, "_On_item_stored")

func _on_ItemButton_button_up():
	var image = self.name
	emit_signal("ButtonPressed", image, CurrentItem)
	

func _On_item_stored(ItemGiven):
	CurrentItem = ItemGiven
	emit_signal("ReceivedItem")

#ps code
# code something that determines which button is pressed
