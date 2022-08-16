extends KinematicBody2D

onready var screen_size = get_viewport_rect().size
onready var _animated_sprite = $TurtAnimatedSprite
onready var _die = $DieAudioStreamPlayer2D
onready var _label = get_node("../UIControl/GameOverLabel")

#var speed = 0.5
var maxspeed = 100
var rotation_speed = 1.5
var friction = 0.025
var acceleration = 0.02

var velocity = Vector2.ZERO
var rotation_dir = 0

var alive = true

func get_input():
	var input = Vector2()
	if (alive):
		rotation_dir = 0
		if Input.is_action_pressed('right'):
			rotation_dir += 1
		elif Input.is_action_pressed('left'):
			rotation_dir -= 1
		
		if Input.is_action_pressed('down'):
			input += transform.y
			_animated_sprite.animation = "walk"
		elif Input.is_action_pressed('up'):
			input -= transform.y
			_animated_sprite.animation = "walk"
		else:
			_animated_sprite.animation = "idle"
	
	return input

func _physics_process(delta):
	var direction = get_input()
	rotation += rotation_dir * rotation_speed * delta
	if direction.length() > 0:
		velocity = lerp(velocity, direction.normalized() * maxspeed, acceleration)
	else:
		velocity = lerp(velocity, Vector2.ZERO, friction)
	velocity = move_and_slide(velocity)
	position.x = wrapf(position.x, 0, screen_size.x)
	position.y = wrapf(position.y, 0, screen_size.y)
	$TurtAnimatedSprite.speed_scale = velocity.length() / maxspeed

func _on_BadMobRigidBody2D_hit():
	alive = false
	_animated_sprite.animation = "dead"
	_label.visible = true
	_die.play()
	pass
