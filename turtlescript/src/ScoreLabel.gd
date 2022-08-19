extends Label

export var score := 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_MobRigidBody2D_hit():
	$"%ChompStreamPlayer2D".play()
	score += 1
	text = tr("SCORE") + ": %s" % score
