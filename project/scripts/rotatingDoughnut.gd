extends Label
# Reference to the Label node

# Screen dimensions
const WIDTH = 40
const HEIGHT = 20

# ASCII characters for the doughnut
const CHARS = ".,-~:;=!*#$@"

# Doughnut parameters
var A = 0.0
var B = 0.0

# Animation timer
var timer = 0.0
var delay = 0.1

# ASCII buffer
var zbuf = []
var screen = []

func _ready():
	# Initialize buffers
	for i in range(WIDTH * HEIGHT):
		zbuf.append(0.0)
		screen.append(" ")
	
	self.set_custom_minimum_size(Vector2(WIDTH * 10, HEIGHT * 20))
	self.horizontal_alignment = 1
	self.vertical_alignment = 1
	# Start the animation
	set_process(true)

func _process(delta):
	timer += delta
	if timer >= delay:
		timer = 0.0
		_draw_doughnut()

func _draw_doughnut():
	A += 0.05
	B += 0.02

	# Clear buffers
	for i in range(WIDTH * HEIGHT):
		zbuf[i] = 0.0
		screen[i] = " "

	for j in range(0, 628, 7):
		for i in range(0, 628, 2):
			var c = sin(i)
			var d = cos(j)
			var e = sin(A)
			var f = sin(j)
			var g = cos(A)
			var h = d + 2.0
			var D = 1.0 / (c * h * e + f * g + 5.0)
			var l = cos(i)
			var m = cos(B)
			var n = sin(B)
			var t = c * h * g - f * e
			var x = int(WIDTH / 2 + WIDTH * D * (l * h * m - t * n))
			var y = int(HEIGHT / 2 + HEIGHT / 2 * D * (l * h * n + t * m))
			var o = int(x + WIDTH * y)
			var N = int(8.0 * ((f * e - c * d * g) * m - c * d * e - f * g - l * d * n))
			if HEIGHT > y and y > 0 and x > 0 and WIDTH > x and D > zbuf[o]:
				zbuf[o] = D
				screen[o] = CHARS[max(N, 0)]

	# Update the Label text
	var output = ""
	for k in range(WIDTH * HEIGHT):
		if k % WIDTH == 0:
			output += "\n"
		output += screen[k]
	
	self.text = output
