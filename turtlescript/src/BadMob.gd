extends RigidBody2D

signal hit
onready var screen_size := get_viewport_rect().size
onready var _sprite := $SnekMobAnimatedSprite
onready var _hiss := $HissAudioStreamPlayer2D

var minspeed := 10
var maxspeed := 30

var random_seed := 12345
var rng := RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.seed = random_seed
	_hiss.play()
	pass # Replace with function body.

func _integrate_forces(_state):
	if linear_velocity.length() < 10 && linear_velocity.length() > -10:
		var torque := rng.randf_range(minspeed, maxspeed)
		applied_force = -Vector2(0, torque * 100).rotated(rotation)
	else:
		applied_force = Vector2.ZERO
		
func _physics_process(delta):
	if linear_velocity.length() < 10 && linear_velocity.length() > -10:
		rotation += rng.randf_range(-15, 15) * delta
	
	position.x = wrapf(position.x, 0, screen_size.x)
	position.y = wrapf(position.y, 0, screen_size.y)
	_sprite.speed_scale = linear_velocity.length() / 100
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_SnekMobVisibilityNotifier2D_screen_exited():
	queue_free()

func _on_SnekMobRigidBody2D_body_entered(body):
	print("snek area entered")
	print(body.name)
	if (body.name == "TurtleKinematicBody2D"):
		emit_signal("hit")
	elif (body.name.countn("SnekMobRigidBody2D") > 0):
		_hiss.play()
	pass # Replace with function body.


func _on_SnekMobRigidBody2D_hit():
	pass # Replace with function body.
