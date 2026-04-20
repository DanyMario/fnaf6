extends Button

@onready var not_active = $not_active
@onready var active = $active

var actived:bool = false
var timer:float = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if timer >= 0 :
		timer -= delta
	
	if actived == true and timer <= 0:
		active.visible = !active.visible
		timer = .5
	pass

func _pressed():
	not_active.visible = false
	active.visible = true
	disabled = true
	actived = true
	timer = .5
	pass
