extends Camera3D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.position = self.position + Vector3(0.02,0,0)
