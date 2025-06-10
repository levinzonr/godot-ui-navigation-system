extends Control


func _ready():
	$Panel/VBoxContainer/Button.pressed.connect(func():
		NavigationController.pop()
	)
	$Panel/VBoxContainer/Button2.pressed.connect(func():
		NavigationController.push("scene_b")
	)
