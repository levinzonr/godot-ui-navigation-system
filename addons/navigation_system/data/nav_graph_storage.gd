class_name NavGraphStorage

var _graph: NavigationGraph


func _init(graph: NavigationGraph):
	_graph = graph
	

func delete_entry_by_name(name: String):
	if _graph.entries.has(name):
		_graph.entries.erase(name)
		ResourceSaver.save(_graph)
		_graph.emit_changed()
	else:
		push_error("Entry with name '%s' does not exist." % name)

		
func add_entry_from_resource(resource_path: String) -> NavigationEntryData:
	if resource_path.is_empty():
		return
	var resource: Resource = load(resource_path)
	var path_segments := resource_path.split("/")
	var file_name = path_segments.get(path_segments.size() - 1)
	print("Paths" + str(path_segments))
	var entry = NavigationEntryData.new()
	entry.name = file_name.split(".")[0]
	entry.scene = resource
	return add_entry(entry)
	
	
func add_entry(entry: NavigationEntryData) -> NavigationEntryData:
	if _graph.entries.has(entry.name):
		return null
	_graph.entries[entry.name] = entry
	
	if _graph.entries.size() == 1:
		_graph.start_name = entry.name
	
	ResourceSaver.save(_graph)
	_graph.emit_changed()
	return entry
