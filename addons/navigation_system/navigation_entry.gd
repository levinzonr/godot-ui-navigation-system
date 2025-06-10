extends Control
class_name NavigationEntry

@export var data: NavigationEntryData


func _ready() -> void:
	# Set anchors to cover the whole screen
	anchor_left = 0.0
	anchor_top = 0.0
	anchor_right = 1.0
	anchor_bottom = 1.0
	add_child(data.scene.instantiate())

func _enter():
	await data.enter_transition.start(self)
	focus_on_first_interactive_element()

func _exit():
	await data.exit_transition.start(self)

func _pop_enter():	
	await data.pop_enter_transition.start(self)
	focus_on_first_interactive_element()

func _pop_exit():	
	await data.pop_exit_transition.start(self)


func focus_on_first_interactive_element():
	focus_on_first_interactive_element_in(self)
	

func focus_on_first_interactive_element_in(parent: Control):
	for child in parent.get_children():
		if child is Control and child.focus_mode != Control.FOCUS_NONE:
			child.grab_focus()
			print("%s grabs focus" % child.name)
			return
		elif child.get_child_count() > 0:
			focus_on_first_interactive_element_in(child)
