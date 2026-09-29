extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const MAX_HP = 200.0

var hp = MAX_HP
var damage = 80.0
var is_attack = false
var is_moving = false
var look_left = false
var is_triggered = false

@onready var sword = $attack_zone/CollisionShape2D
@onready var walk = $walk_timer
@onready var wait = $wait_timer
@onready var player = $"../PLAYER"


func _process(_delta: float) -> void:
	sword.disabled = not is_attack
	if hp <= 0:
		walk.stop()
		wait.stop()
		is_moving = false

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	if is_moving and not is_attack:
		if is_triggered:
			scale.x *= -1 if look_left and player.position.x > position.x or\
		 not look_left and player.position.x <= position.x else 1
			look_left = player.position.x <= position.x
		velocity.x = (-1 if look_left else 1) * SPEED * delta
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()


func _on_sword_body_entered(body: Node2D) -> void:
	if body.name.find('PLAYER') != -1:
		body.hp -= damage


func _on_walk_timer_timeout() -> void:
	is_moving = false
	wait.start()


func _on_wait_timer_timeout() -> void:
	scale.x *= -1
	look_left = not look_left
	is_moving = true
	walk.start()
	


func _on_view_zone_body_entered(body: Node2D) -> void:
	if body == player:
		walk.stop()
		wait.stop()
		is_moving = true
		is_triggered = true



func _on_view_zone_body_exited(body: Node2D) -> void:
	if body == player:
		wait.start()
		is_moving = false
		is_triggered = false
