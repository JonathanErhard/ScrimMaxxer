extends Node3D

var t = 0
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	t += delta
	self.rotation = Vector3(0,-sin(t)+135,0)
