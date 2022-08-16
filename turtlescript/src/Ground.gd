extends Node2D

export(PackedScene) var mob_scene
export(PackedScene) var bad_mob_scene

onready var screen_size = get_viewport_rect().size
onready var _game_over = $UIControl/GameOverLabel
onready var _score = get_node("UIControl/ScoreLabel")
onready var _turt = $TurtleKinematicBody2D
onready var _versionLabel = $"%VersionLabel"

var version = ProjectSettings.get_setting("application/config/version")
var build = ProjectSettings.get_setting("application/config/build") as String
var version_display = version + " " + build

var random_seed = 12345
var rng = RandomNumberGenerator.new()

#TODO: sound effects
#TODO: main menu, new game
#TODO: difficulty level selection

# Called when the node enters the scene tree for the first time.
func _ready():
	seed(random_seed)
	rng.seed = random_seed
	_versionLabel.text = "v " + version_display
	
	_score.text = tr("SCORE") + ": 0"
	_game_over.text = tr("GAME_OVER")
	_game_over.hint_tooltip = tr("GAME_OVER_TIP")
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_MobTimer_timeout():
	var mob = mob_scene.instance()
	#var mob_spawn_location = get_node("MobPath2D/MobPathFollow2D")
	#mob_spawn_location.offset = randi()
	#mob.position = mob_spawn_location.position
	var randSource = rng.randi_range(1, 4)
	var mobPad = 10
	var speed = rng.randf_range(20.0, 75.0)
	var angle = rng.randf_range(-25.0, 25.0)
	if (randSource == 1):
		# North
		mob.position.y = 0 + mobPad
		mob.position.x = screen_size.x / 2
		mob.position.x += rng.randf_range(-300.0, 300.0)
		mob.linear_velocity = Vector2(angle, speed)
	elif (randSource == 2):
		# East
		mob.position.y = screen_size.y / 2
		mob.position.y += rng.randf_range(-150.0, 150.0)
		mob.position.x = screen_size.x - mobPad
		mob.linear_velocity = Vector2(-speed, angle)
	elif (randSource == 3):
		# South
		mob.position.y = screen_size.y - mobPad
		mob.position.x = screen_size.x / 2
		mob.position.x += rng.randf_range(-300.0, 300.0)
		mob.linear_velocity = Vector2(angle, -speed)
	elif (randSource == 4):
		# West
		mob.position.y = screen_size.y / 2
		mob.position.y += rng.randf_range(-150.0, 150.0)
		mob.position.x = 0 + mobPad
		mob.linear_velocity = Vector2(speed, angle)

	add_child(mob)
	# We connect the mob to the score label to update the score upon squashing one.
	mob.connect("hit", _score, "_on_MobRigidBody2D_hit")
	pass

func _on_TurtleKinematicBody2D_hit():
	print("ground turt hit")
	pass # Replace with function body.

func _on_BadMobTimer_timeout():
	var bad = bad_mob_scene.instance()
	var randSource = rng.randi_range(1, 4)
	var mobPad = 10
	var speed = rng.randf_range(25.0, 120.0)
	var anglex = rng.randf_range(-25.0, 25.0)
	var angley = rng.randf_range(-25.0, 25.0)
	var rot = rng.randf_range(40.0, 50.0)
	if (randSource == 1):
		# Northeast
		bad.position.y = 0 + mobPad
		bad.position.x = screen_size.x - mobPad
		bad.rotation_degrees -= (90 + rot)
		#bad.rotation = deg2rad(-90 - rot)
		bad.linear_velocity = Vector2(-speed + anglex, speed + angley)
	elif (randSource == 2):
		# Southeast
		bad.position.y = screen_size.y - mobPad
		bad.position.x = screen_size.x - mobPad
		bad.rotation_degrees -= rot
		#bad.rotation = deg2rad(0 - rot)
		bad.linear_velocity = Vector2(-speed + anglex, -speed + angley)		
	elif (randSource == 3):
		# Southwest
		bad.position.y = screen_size.y - mobPad
		bad.position.x = 0 + mobPad
		bad.rotation_degrees += rot
		#bad.rotation = deg2rad(0 + rot)
		bad.linear_velocity = Vector2(speed + anglex, -speed + angley)		
	elif (randSource == 4):
		# Northwest
		bad.position.y = 0 + mobPad
		bad.position.x = 0 + mobPad
		bad.rotation_degrees += (90 + rot)
		#bad.rotation = deg2rad(90 + rot)		
		bad.linear_velocity = Vector2(speed + anglex, speed + angley)
		
	#bad.linear_velocity = Vector2(angle, -speed)
	add_child(bad)
	
	# We connect the mob to the score label to update the score upon squashing one.
	bad.connect("hit", _turt, "_on_BadMobRigidBody2D_hit")
