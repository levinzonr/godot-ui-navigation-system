extends EditorInspectorPlugin

signal graph_resource_selected(graph: NavigationGraph)

func _can_handle(object: Object) -> bool:
	return object is NavigationGraph
	
func _parse_property(object: Object, type: int, name: String, hint_type: int, hint_string: String, usage_flags: int, wide: bool) -> bool:
	graph_resource_selected.emit(object as NavigationGraph)
	print("Graph resource selected: ", object)
	return false
		
func _parse_begin(object: Object) -> void:
	print("Begin parsing NavigationGraph properties")
