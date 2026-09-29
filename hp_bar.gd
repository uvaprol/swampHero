extends ColorRect

const SPEED = 15.0
@onready var player = $".."
@onready var hp_line = $hp_line
@onready var hp_line_post = $hp_line_post


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	hp_line.size.x = (100 * player.hp) / player.MAX_HP
	hp_line_post.size.x -= int(hp_line.size.x < hp_line_post.size.x) * delta * SPEED
