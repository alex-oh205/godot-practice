extends Node

onready var viewport1 = $Viewports/ViewportContainer1/Viewport1
onready var viewport2 = $Viewports/ViewportContainer2/Viewport2
onready var camera1 = $Viewports/ViewportContainer1/Viewport1/Camera2D
onready var camera2 = $Viewports/ViewportContainer2/Viewport2/Camera2D
onready var world = $Viewports/ViewportContainer1/Viewport1/Map01

func _ready():
	viewport2.world_2d = viewport1.world_2d
	$Minimap/Viewport.world_2d = viewport1.world_2d
	camera1.target = world.get_node("Player_1")
	camera2.target = world.get_node("Player_2")
	set_camera_limits()

func set_camera_limits():
	var map = world.get_node("Ground")
	var map_limits = map.get_used_rect()
	var map_cellsize = map.cell_size
	for cam in [camera1, camera2]:
		cam.limit_left = map_limits.position.x * map_cellsize.x
		cam.limit_right = map_limits.end.x * map_cellsize.x
		cam.limit_top = map_limits.position.y * map_cellsize.y
		cam.limit_bottom = map_limits.end.y * map_cellsize.y
