@tool
extends EditorPlugin

var _editor_scene: PackedScene = preload("res://addons/navigation_system/ui/editor/navigation_graph_editor.tscn")
var _nav_entry_inspector_res = preload("res://addons/navigation_system/ui/inspector/nav_entry_inspector_plugin.gd")
var _nav_graph_inspector_res = preload("res://addons/navigation_system/ui/inspector/nav_graph_inspector_plugin.gd")


var _editor: Control
var _nav_entry_inspector: EditorInspectorPlugin
var _nav_graph_inspector: EditorInspectorPlugin

var plugin_path: String:
	get(): return get_script().resource_path.get_base_dir()

func _enter_tree():
	_editor = _editor_scene.instantiate()
	_nav_entry_inspector = _nav_entry_inspector_res.new()
	_nav_graph_inspector = _nav_graph_inspector_res.new()
	
	add_inspector_plugin(_nav_entry_inspector)
	add_inspector_plugin(_nav_graph_inspector)
	get_editor_interface().get_inspector().edited_object_changed.connect(_edited_object_changed)
	
	add_control_to_bottom_panel(_editor, "Navigation System")
	

func _enable_plugin():
	add_autoload_singleton("NavigationController",  plugin_path + "/navigation_controller.gd")


func _disable_plugin() -> void:
	remove_autoload_singleton("NavigationController")

func _handles(object):
	return object is NavigationGraph

func _exit_tree():
	remove_inspector_plugin(_nav_entry_inspector)
	remove_inspector_plugin(_nav_graph_inspector)
	remove_control_from_bottom_panel(_editor)
	_editor.queue_free()
	
func _edit(object):
	if object is NavigationGraph:
		print("Edit navgrpag")
		_show_graph_editor(object)	
		
func _edited_object_changed():
	var value = get_editor_interface().get_inspector().get_edited_object()

func _show_graph_editor(graph: NavigationGraph) -> void:
	_editor.set_graph_resource(graph)
	make_bottom_panel_item_visible(_editor)
