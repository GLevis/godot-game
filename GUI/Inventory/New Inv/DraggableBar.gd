extends Panel

var parent = null;
var drag = false;
var offset = Vector2(0, 0);
var status

func _ready():
	parent = get_parent();

func _input(event : InputEvent):
	if parent && drag:
		status = "clicked"
	
	if status == "clicked" && event is InputEventMouseMotion:
		status = "dragging"
	
	if status == "dragging":
		if event.get_button_mask() != BUTTON_LEFT:
			status = "released"
		else:
			parent.rect_global_position = event.global_position

func _gui_input(event : InputEvent):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		drag = event.pressed;
		offset = event.global_position - parent.rect_global_position;
