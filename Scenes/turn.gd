extends AnimatedSprite2D


var last_played

enum DIRECTION{
	forward,
	left,
	right
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false
	animation_finished.connect(_on_animation_finished)	 # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func turn(back:bool, direction: DIRECTION):
	visible = true
	match direction:
		DIRECTION.left:
			if back:
				play("left backwards")
				last_played = "backwards"
			else:
				play("left")
				last_played = "forwards"
		DIRECTION.right:
			if back:
				play("right backwards")
				last_played = "backwards"
			else:
				play("right")
				last_played = "forwards"
	pass

func _on_animation_finished():
	if last_played == "backwards":
		visible = false
	pass # freezes on last frame
