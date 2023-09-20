extends Node2D

var noise = OpenSimplexNoise.new()
var z = 0
var cell_size = 5
var speed = 4
var screensize

func _ready():
	screensize = get_viewport_rect().size
	randomize()
	noise.seed = randi()
	noise.period = 16
	noise.octaves = 8

func _process(delta):
	z += speed * delta
	update()
	
func _draw():
	for x in int(screensize.x/cell_size):
		for y in int(screensize.y/cell_size):
			var val = noise.get_noise_3d(x, y, z) * 0.5 + 0.5
			var color = Color(1.0-val/2.0, 0.5-val/2.0, val/4.0)
			var r = Rect2(x*cell_size, y*cell_size, cell_size, cell_size)
			draw_rect(r, color)  # lava
			# draw_rect(r, color)