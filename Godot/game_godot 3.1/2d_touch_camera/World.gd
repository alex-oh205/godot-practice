extends Node2D


func _ready():
	$TouchCamera2D.position = $Player.position
