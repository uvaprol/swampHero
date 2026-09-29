extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const MAX_HP = 200.0
const MAX_STAMINA = 400.0
const MAX_MANA = 200.0

var hp = MAX_HP
var damage = 80.0
var speed_boost = 2.0
var stamina = MAX_STAMINA
var mana = MAX_MANA
var is_attack = false
var is_moving = false
var look_left = false

@onready var sword = $Area2D/CollisionShape2D


func _process(_delta: float) -> void:
	sword.disabled = not is_attack
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		is_attack = true


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("ui_up") and is_on_floor() and not is_attack:
		velocity.y = JUMP_VELOCITY

	var direction := Input.get_axis("ui_left", "ui_right")
	is_moving = bool(direction)
	if direction and not is_attack:
		velocity.x = direction * SPEED
		scale.x = -1 if look_left and direction == 1 or\
		 not look_left and direction == -1 else 1
		look_left = direction == -1
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name.find('ENEMY') != -1:
		body.hp -= damage
