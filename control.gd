extends Control

@onready var tab = $TabBar
@onready var tasks = $Tasks
@onready var motion = $Motion


signal set_task_visual(is_actual:bool)

enum TABS{
	TASKS,
	MOTION,
	AUDIO,
	VENT
}

var current: TABS = TABS.TASKS
var active = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	tab.current_tab = current
	motion.active.connect(activated)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if tab.current_tab == TABS.TASKS:
		tasks.visible = true
		motion.visible = false
	elif tab.current_tab == TABS.MOTION:
		tasks.visible = false
		motion.visible = true
	else:
		tasks.visible = false
	
	pass
func activated(name:TABS):
	tab.active = name
	pass

	
	
