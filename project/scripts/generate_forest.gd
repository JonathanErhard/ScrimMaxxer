extends Node

var brig:Node3D
var camera:Node3D
var tree = preload("res://assets/Tree/lowpolystylizedgntree3.6fbx.glb")

var chunk_range = 5
#chunk parameters
var chunk_size = 10 #meters
var trees_per_chunk = 3
var min_distance = 2

var path_width = 2

var curx = 0
var cury = 0

var t = 0.0

var loaded_chunks = [[[]]]

var rng = RandomNumberGenerator.new()

func spawn_tree(pos:Vector3):
	var tree_instance = tree.instantiate()
	var scale = rng.randf_range(0.1, 1.0)
	tree_instance.scale = Vector3(scale,scale,scale)
	tree_instance.position = pos
	tree_instance.rotation = Vector3(0,randf_range(0,360),0)
	add_child(tree_instance)
	return tree_instance
	
# x and y are the middle 
func _spawn_forest_chunk(x:int,y:int):
	
	for i in range(0,trees_per_chunk):
		var pos_x = 10.0*x+rng.randf_range(0.0,10.0)
		var pos_z = 10.0*y+rng.randf_range(0.0,10.0)
		while pos_z > -path_width and pos_z < path_width:
			pos_z = 10.0*y+rng.randf_range(0.0,10.0)
		var tree_instance = spawn_tree(Vector3(pos_x,0,pos_z))
		loaded_chunks[(x+chunk_range)%(2*chunk_range+1)][(y+chunk_range)%(2*chunk_range+1)].append(tree_instance)

func _despawn_forest_chunk(x:int,y:int):
	for rotten_tree in loaded_chunks[(x+chunk_range)%(2*chunk_range+1)][(y+chunk_range)%(2*chunk_range+1)]:
		remove_child(rotten_tree)
	loaded_chunks[(x+chunk_range)%(2*chunk_range+1)][(y+chunk_range)%(2*chunk_range+1)] = []

func _ready():
	camera = get_tree().get_root().get_node("Node3D").get_node("Camera3D")
	brig = camera.get_node("brig") as Node3D
	for x in range(0,2*chunk_range+1):
		loaded_chunks.append([[]])
		for y in range(0,2*chunk_range+1):
			loaded_chunks[x].append([])
	for x in range(-chunk_range,chunk_range):
		for y in range(-chunk_range,chunk_range):
			_spawn_forest_chunk(x,y)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	t += delta
	if(camera.position.x/chunk_size-1 > curx):
		for y in range(-chunk_range,chunk_range):
			_despawn_forest_chunk(curx+chunk_range,y)
			_spawn_forest_chunk(curx+chunk_range,y)
		curx += 1
