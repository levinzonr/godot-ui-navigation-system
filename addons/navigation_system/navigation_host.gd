@tool
extends Control
class_name NavigationHost

var _back_stack: Array[NavigationEntry]
@export var nav_graph: NavigationGraph

func _ready():
	add_to_group("navigation_host")
	push(nav_graph.start_name)
		

func push(name: StringName):
	var entry = NavigationEntry.new()
	entry.data = nav_graph.entries[name]
	
	if not _back_stack.is_empty():
		var current = _back_stack.back()
		current._pop_exit()
		
	add_child(entry)
	_back_stack.append(entry)
	entry._enter()
	

func pop():
	if not _back_stack.is_empty():
		var current: NavigationEntry = _back_stack.pop_back()
		await current._exit()
		current.queue_free()
	
	if not _back_stack.is_empty():
		var new: NavigationEntry = _back_stack.back()
		new._pop_enter()
