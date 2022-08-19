extends RigidBody2D

signal hit
onready var screen_size := get_viewport_rect().size
onready var _eat := $EatStreamPlayer2D as AudioStreamPlayer2D
onready var _death := $DeathTimer as Timer

var minspeed := -25
var maxspeed := 25
var isDying := false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	position += transform.x * rand_range(minspeed, maxspeed) * delta
	position += transform.y * rand_range(minspeed, maxspeed) * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_MobVisibilityNotifier2D_screen_exited():
	queue_free()

func _on_MobRigidBody2D_body_entered(body):
	print("body area entered")
	print(body.name)
	if (body.name == "TurtleKinematicBody2D"):
		emit_signal("hit")
		queue_free()
	elif (body.name.countn("SnekMobRigidBody2D") > 0 && !isDying):
		isDying = true
		_eat.play()
		visible = false
		_death.start()
	pass # Replace with function body.

func _on_MobRigidBody2D_hit():
	pass # Replace with function body.


func _on_DeathTimer_timeout():
	queue_free()
	pass # Replace with function body.
