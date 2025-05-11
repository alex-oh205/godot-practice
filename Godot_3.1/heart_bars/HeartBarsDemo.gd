extends Control

var current_health = 5 setget update_bars

func _ready():
	self.current_health = 5
	
func update_bars(value):
	current_health = value
	# print("Health: ", current_health)
	$Label.text = "Current Health: %s" % value
	for bar in $Bars.get_children():
		bar.update_health(current_health)
	
func _on_AddButton_pressed():
	self.current_health += 1

func _on_SubtractButton_pressed():
	self.current_health -= 1
