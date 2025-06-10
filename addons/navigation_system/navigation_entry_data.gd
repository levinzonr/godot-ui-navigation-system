extends Resource
class_name NavigationEntryData

@export var name: StringName
@export var scene: PackedScene
@export var enter_transition: NavigationEntryTransition
@export var exit_transition: NavigationEntryTransition
@export var pop_enter_transition: NavigationEntryTransition
@export var pop_exit_transition: NavigationEntryTransition


func _init():
	if enter_transition == null:
		enter_transition = FadeInTransition.new()
		
	if exit_transition == null:		
		exit_transition = FadeOutTransition.new()
		
	if pop_enter_transition == null:
		pop_enter_transition = FadeInTransition.new()
		
	if pop_exit_transition == null:
		pop_exit_transition = FadeOutTransition.new()
