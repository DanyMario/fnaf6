extends TabBar


enum TABS{
	TASKS,
	MOTION,
	AUDIO,
	VENT
}

var active = null

@export var Tabs: Array[Texture2D]
@export var SelectedTabs: Array[AnimatedTexture]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var i = 0
	for textu in Tabs:
		set_tab_icon(i,textu)
		i += 1
	
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (current_tab != active) and active != null:
		if get_tab_icon(active) == Tabs[active]:
			set_tab_icon(active,SelectedTabs[active])
	
	for i in range(len(Tabs)):
		if get_tab_icon(i) == SelectedTabs[i] and  (i != active or i == current_tab):
			set_tab_icon(i, Tabs[i]) 
	pass
