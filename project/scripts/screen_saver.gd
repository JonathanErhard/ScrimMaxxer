extends Node

var time_since_motion = 0

func _input(event):
	if event is InputEventMouse or event is InputEventKey:
		time_since_motion = 0

func _process(delta):
	time_since_motion += delta
	if(time_since_motion > 2):
		var packed_scene = PackedScene.new()
		packed_scene.pack(get_tree().get_current_scene())
		ResourceSaver.save(packed_scene,"res://temp/saved_scene.tscn")
		get_tree().change_scene_to_file("res://scenes/procedural_forest.tscn")
