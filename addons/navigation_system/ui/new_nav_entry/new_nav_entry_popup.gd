extends PopupPanel

var picker: EditorResourcePicker

func _ready():
	picker = EditorResourcePicker.new()
	$VBoxContainer.add_child(picker)
	picker.resource_selected.connect(func(res):
		$VBoxContainer/Label.text = str(res)
	)
