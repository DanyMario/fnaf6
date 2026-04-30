extends Node2D

@onready var move = $AnimatedSprite2D
@onready var main_stage = $Sprite2D
@onready var desktop = $Desktop

enum DIRECTION{
	forward,
	left,
	right
}

@onready var direction = DIRECTION.forward

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in get_children():
		if i.has_signal("moving"):
			i.moving.connect(moving)
		
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func moving(directions:DIRECTION):
	desktop.visible = false
	main_stage.visible = false
	if directions == DIRECTION.left:
		if direction == DIRECTION.forward: 
			move.turn(false,DIRECTION.left)
			direction = DIRECTION.left
		if direction == DIRECTION.right:
			move.turn(true, DIRECTION.right)
			direction = DIRECTION.forward
			desktop.visible = true
			main_stage.visible = true
	if directions == DIRECTION.right:
		if direction == DIRECTION.forward: 
			move.turn(false,DIRECTION.right)
			direction = DIRECTION.right
		if direction == DIRECTION.left:
			move.turn(true, DIRECTION.left)
			direction = DIRECTION.forward 
			desktop.visible = true
			main_stage.visible = true
