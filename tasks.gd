extends Control

enum TASKS{
	MAIN,
	SUPLIES,
	ADS,
	MAINTENCES,
	EQUIPMENT
}

@onready var suplies = $VBoxContainer
@onready var main = $Main
@onready var back = $TextureButton

var last_tab:TASKS = TASKS.MAIN


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in get_children():
		if i == main:
			i.visible = true
		else:
			i.visible = false
		
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if main.visible == false and visible != false:
		back.visible = true
	pass


func on_control_set_task_visual(is_actual: bool) -> void:
	if is_actual == false:
		for i in get_children():
			i.visible = false
	else:
		set_visible_task(last_tab)
		
	pass # Replace with function body.
	
func set_visible_task(tab:TASKS)->void:
	if tab == TASKS.MAIN:
		for i in get_children():
			if i == main:
				i.visible = true
			else:
				i.visible = false
		
	if tab == TASKS.SUPLIES:
		for i in get_children():
			if i == suplies or i == back:
				i.visible = true
			else:
				i.visible = false



func _on_main_item_selected(index: int) -> void:
	set_visible_task(index+1)
	
	pass # Replace with function body.


func _on_back_item_selected() -> void:
	set_visible_task(TASKS.MAIN)
	pass # Replace with function body.
