extends AnimatedSprite2D
@onready var player = $".."

func _ready() -> void:
	play("idle")


func _process(_delta: float) -> void:
	if player.hp > 0:
		if not player.is_on_floor():
			play("jump")
		else:
			if player.is_attack:
				play("attack2")
			elif player.is_moving:
				play("run")
			else:
				play("idle")
	else:
		play("death")   


func _on_animation_looped() -> void:
	if player.is_attack:
		player.is_attack = false
	if player.hp <= 0:
		player.queue_free()
	print(player.name , $"..".hp)
