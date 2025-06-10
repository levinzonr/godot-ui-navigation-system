@tool
extends GraphNode
class_name DestinationNode

@onready var sub_viewport: SubViewport = %SubViewport
@onready var texture: TextureRect = $TextureRect

@export var scene: PackedScene

var is_start_destination: bool = false

func _ready():
	add_scene_preview()


func add_scene_preview():
	var instance = scene.instantiate()
	sub_viewport.add_child(instance)
