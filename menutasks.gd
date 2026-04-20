extends VBoxContainer 

@onready var parent_node = get_parent()

var timer = 0
var current_task = null
signal task_doing(in_rn)

var all_done:bool
var send_signal_done:bool = false
signal all_tasks_complete(name:String)

@export var buying_menu: bool = false
signal buying

var task_status = {}
var all_tasks = []

@export var task_timer:int
@export var upgrade_timer:int
@export var upgrade: UPGRADES


enum UPGRADES{
	printer,
	hs_internet,
	handyman
}


func _ready() -> void:
	for button in get_children():
		if button is TextureButton:
			all_tasks.append(button.name)
			task_status[button.name] = false
			button.pressed.connect(_on_button_pressed.bind(button))
			
	print(all_tasks)

func _process(delta: float) -> void:
	if timer > 0:
		timer -= delta  
	
		if timer <= 0 and current_task != null:
			current_task.visible = false
			task_status[current_task.name] = true
			current_task = null
			task_doing.emit(false)
		elif current_task != null and !is_visible_in_tree():
			current_task.get_node("loading").visible = false
			current_task=null
			timer = 0
			task_doing.emit(false)
			print("Stopped!")
	
	if buying_menu == false:
		if all_done == false:
			all_done = check_status()
		elif !send_signal_done:
			all_tasks_complete.emit(name)
			send_signal_done = true
			


func _on_button_pressed(button):
	if !buying_menu:
		if current_task != null:
			current_task.get_node("loading").visible = false 
			current_task=null
			timer = 0
			print("Stopped!")
			task_doing.emit(false)
		var rect = button.get_node("loading")
		rect.visible = !rect.visible
		
		current_task = button
		task_doing.emit(true)
		if parent_node.upgrades[upgrade] == true:
			timer = upgrade_timer
		else:
			timer = task_timer 
	else:
		match button.name:
			"printer":
				buying.emit(UPGRADES.printer)
			"hs_internet":
				buying.emit(UPGRADES.hs_internet)
			"handyman":
				buying.emit(UPGRADES.handyman)

func check_status() -> bool:
	var check
	check = true

	for task in task_status:
		if !task_status[task]:
			check = false
	return check

func on_buy_result(upgrade,is_bought):
	if is_bought:
		match upgrade:
			UPGRADES.printer:
				get_node("printer").visible = false
				print("Bought: printer")
			UPGRADES.hs_internet:
				get_node("hs_internet").visible = false
				print("Bought: internet")
			UPGRADES.handyman:
				get_node("handyman").visible = false
				print("Bought: handyman")
