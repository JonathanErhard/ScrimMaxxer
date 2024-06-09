extends Button

func _on_pressed():
	# This is like autoloading the scene, only
	# it happens after already loading the main scene.
	print("changing to Background")
	get_tree().change_scene_to_file("res://scenes/backgroundCheck.tscn")
