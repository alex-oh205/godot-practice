extends Node2D

func _ready():
	for bomb in $Bombs.get_children():
		bomb.connect("exploded", self, "_on_Bomb_exploded")
		
func _on_Bomb_exploded():
	$ShakeCamera2D.add_trauma(0.5)

func _unhandled_input(event):
	if event.is_action_pressed("ui_focus_next"):
		$ShakeCamera2D.add_trauma(0.25)
	
func _process(delta):
	$CanvasLayer/HBoxContainer/TraumaBar.value = $ShakeCamera2D.trauma * 100
	$CanvasLayer/HBoxContainer/ShakeBar.value = pow($ShakeCamera2D.trauma, $ShakeCamera2D.trauma_power) * 100