extends HBoxContainer

# Define your colors
var SELECTED_COLOR = Color.AQUAMARINE
var NORMAL_COLOR = Color.WHITE # A dark grey to look "unselected"

func _ready():
	# Connect signals for all your buttons
	for child in get_children():
		if child is TextureButton:
			child.pressed.connect(_on_tab_pressed.bind(child))

func _on_tab_pressed(pressed_button: TextureButton):
	# Reset all tabs to normal color
	for child in get_children():
		if child is TextureButton:
			child.modulate = NORMAL_COLOR

	# Highlight only the pressed button
	pressed_button.modulate = SELECTED_COLOR
