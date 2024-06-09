extends Node3D

func _process(delta):
	self.rotate(Vector3(0,1,0).normalized(),delta*2)
