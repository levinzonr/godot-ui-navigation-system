@tool
extends GraphEdit
@export var graph: NavigationGraph
@onready var  node_resource = preload("res://addons/navigation_system/ui/destination_node.tscn")

var selected_node: DestinationNode
var storage: NavGraphStorage

func _ready():
	storage = NavGraphStorage.new(graph)
	create_graph()
	popup_request.connect(handle_popup_request_at)
	node_selected.connect(func(node):
		selected_node = node
	)
	
	node_deselected.connect(func(node):
		selected_node = null
	)
	

func set_graph_resource(graph_resource: NavigationGraph):
	graph = graph_resource
	storage = NavGraphStorage.new(graph)
	_clear_graph()
	create_graph()

func handle_popup_request_at(position: Vector2):
	if selected_node == null:
		_show_new_node_dialog()
	else:
		var popup: PopupMenu = PopupMenu.new()
		popup.add_item("Make Start Destination")
		popup.add_item("Delete")
		popup.add_item("Open Scene")
		popup.index_pressed.connect(func(index):
			_handle_popup_result(index)
		)
		var global_pos = self.get_global_position() + position
		popup.position = global_pos
		
		EditorInterface.popup_dialog(popup)


func _handle_popup_result(index):
	match index:
		0:
			print("Save name" + selected_node.title)
			graph.start_name = selected_node.title
			ResourceSaver.save(graph)
			print(str(graph.start_name))
		1:
			storage.delete_entry_by_name(selected_node.title)
			selected_node.queue_free()
		2:
			EditorInterface.open_scene_from_path(selected_node.scene.resource_path)
	
func _show_new_node_dialog():
	EditorInterface.popup_quick_open(_handle_new_resource, ["PackedScene"]);
	

func _handle_new_resource(res: String):
	var new_entry = storage.add_entry_from_resource(res)
	if new_entry:
		_add_node_from_entry(new_entry)
	else:
		push_error("Failed to add entry from resource: " + res)
	
func _clear_graph():
	print("Clear Graph")
	for child in get_children():
		if child is DestinationNode:
			child.queue_free()
	
func create_graph():
	print("Create Graph")
	var offset: Vector2 = Vector2(100, 100)
	for entry_name in graph.entries:
		print("New Entry: " + str(entry_name))
		var entry = graph.entries[entry_name]
		var preview: DestinationNode = node_resource.instantiate()
		preview.scene = entry.scene
		preview.title = entry.name
		preview.is_start_destination = entry.name == graph.start_name
		preview.position = offset
		offset += Vector2.ONE * 100
		add_child(preview)
		preview.node_selected.connect(func():
			EditorInterface.edit_resource(entry)
		)
	arrange_nodes()

	
func _add_node_from_entry(navigation_entry: NavigationEntryData):
	var preview: DestinationNode = node_resource.instantiate()
	preview.scene = navigation_entry.scene
	preview.title = navigation_entry.name
	preview.position = Vector2.ZERO
	preview.is_start_destination = navigation_entry.name == graph.start_name
	add_child(preview)
	preview.node_selected.connect(func():
		EditorInterface.edit_resource(navigation_entry)
	)
	arrange_nodes()
	
