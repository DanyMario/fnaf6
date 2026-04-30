extends Area2D
signal moving(direction)

enum DIRECTION{
	forward,
	left,
	right
}

@export var direction:DIRECTION

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mouse_entered.connect(_on_area_2d_mouse_entered)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_area_2d_mouse_entered():
	moving.emit(direction)
	

func _on_area_2d_mouse_exited():
	print("Mouse exited")
