extends Control

onready var _versionLabel := $"%VersionLabel"

var version := ProjectSettings.get_setting("application/config/version") as String
var build := ProjectSettings.get_setting("application/config/build") as String
var version_display := version + "  " + build

# Called when the node enters the scene tree for the first time.
func _ready():
	_versionLabel.text = "v " + version_display
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_StartButton_pressed():
	get_tree().change_scene("res://scenes/Ground.tscn")
	pass # Replace with function body.
