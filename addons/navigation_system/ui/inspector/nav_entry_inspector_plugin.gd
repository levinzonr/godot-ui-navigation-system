extends EditorInspectorPlugin


func _can_handle(object: Object) -> bool:
	return object is NavigationEntryData
	
func _parse_property(object: Object, type: int, name: String, hint_type: int, hint_string: String, usage_flags: int, wide: bool) -> bool:
	return false
		
