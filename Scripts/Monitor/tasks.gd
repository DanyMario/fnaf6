extends Control

enum TASKS{
	MAIN,
	SUPLIES,
	ADS,
	MAINTENCES,
	EQUIPMENT,
	SHUTDOWN
}

enum UPGRADES{
	printer,
	hs_internet,
	handyman
}

@onready var suplies = $Suplies2
@onready var main = $Main
@onready var ads = $ads
@onready var back = $TextureButton
@onready var please_wait = $please_wait
@onready var maint  = $maint
@onready var equip = $equip
@onready var number = $TextureRect

var upgrades:Dictionary[UPGRADES,bool] = {UPGRADES.printer: false, UPGRADES.hs_internet: false, UPGRADES.handyman: false}

var tasks_progresion:Dictionary[String,bool]

var last_tab:TASKS = TASKS.MAIN

var intask:bool = false

var timer:float = 0.0
var money = 1900


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in get_children():
		if i == main or i == number:
			i.visible = true
			if i == number:
				i.get_node("money_label").text = var_to_str(money)
		else:
			i.visible = false
		
		if i.has_signal("task_doing"):
			i.task_doing.connect(set_visible_please_wait)
		
		if i.has_signal("buying"):
			i.buying.connect(buying)
			
		if i.has_signal("all_tasks_complete"):
			i.all_tasks_complete.connect(all_tasks_done)
			if i.buying_menu == false:
				tasks_progresion[i.name] = false
		
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if timer > 0:
		timer -= delta  
	
	if main.visible == false and visible != false:
		back.visible = true
	
	if intask == true and timer <= 0 and visible  != false:
		please_wait.visible = !please_wait.visible
		timer = .5
	
	if number.get_node("money_label").text != var_to_str(money):
		number.get_node("money_label").text = var_to_str(money)
	
	if task_checker() == true:
		main.set_item_disabled(4,false)
		main.set_item_selectable(4, false)
		
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
			if i == main or i == number:
				i.visible = true
			else:
				i.visible = false
		
	elif tab == TASKS.SUPLIES:
		for i in get_children():
			if i == suplies or i == back or i == number:
				i.visible = true
			else:
				i.visible = false
		
	elif tab == TASKS.ADS:
		for i in get_children():
			if i == ads or i == back or i == number:
				i.visible = true
			else:
				i.visible = false
	elif tab == TASKS.MAINTENCES:
		for i in get_children():
			if i == back or i == maint or i == number:
				i.visible = true
			else:
				i.visible = false
	elif tab == TASKS.EQUIPMENT:
		for i in get_children():
			if i == back or i == equip or i == number:
				i.visible = true
			else:
				i.visible = false



func _on_main_item_selected(index: int) -> void:
	if index == 4:
		get_tree().quit()
	set_visible_task(index+1)
	pass # Replace with function body.


func _on_back_item_selected() -> void:
	set_visible_task(TASKS.MAIN)
	pass # Replace with function body.

func set_visible_please_wait(is_rn:bool):
	intask = is_rn
	if !is_rn:
		please_wait.visible = false

func buying(upgrade):
		var cost = get_cost(upgrade)
		if money >= cost:
			money -= cost
			upgrades[upgrade] = true
			equip.on_buy_result(upgrade, true)
		else:
			equip.on_buy_result(upgrade, false)
			

func get_cost(upgrade:UPGRADES):
	if upgrade == UPGRADES.printer:
		return 500
	elif upgrade == UPGRADES.hs_internet:
		return 500
	else:
		return 900


func all_tasks_done(name:String) -> void:
	tasks_progresion[name] = true

func task_checker() -> bool:
	for section in tasks_progresion.values():
		if section == false:
			return false
	return true
