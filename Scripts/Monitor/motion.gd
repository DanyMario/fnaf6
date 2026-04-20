extends Control

@onready var player = $Map/player
@onready var activate = $Map/activate

var activated:bool = false
signal active(name)

var blinking_player_timer:float = .5
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in get_children():
		if i.has_signal("pressed"):
			i.pressed.connect(_on_activate)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if blinking_player_timer >= 0 :
		blinking_player_timer -= delta
	
	if blinking_player_timer <= 0:
		player.visible = !player.visible
		blinking_player_timer = .2
	pass

func _on_activate():
	active.emit(get_parent().TABS.MOTION)
	print("OMG IT PRESSED")
	pass
