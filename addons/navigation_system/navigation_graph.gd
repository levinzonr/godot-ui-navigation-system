extends Resource
class_name NavigationGraph

signal entry_added
signal entry_removed

@export  var start_name: StringName
@export  var entries: Dictionary[StringName, NavigationEntryData]


var start_entry: NavigationEntryData:
	get(): return entries[start_name]
