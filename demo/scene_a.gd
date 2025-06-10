extends Control


func _ready():
	$Panel/VBoxContainer/ButtonB.pressed.connect(func():
		NavigationController.push("scene_b")
	)
	$Panel/VBoxContainer/ButtonC.pressed.connect(func():
		NavigationController.push("scene_c")
	)
