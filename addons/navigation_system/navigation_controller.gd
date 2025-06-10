extends Node

# Finds the current NavigationHost in the scene tree
func get_current_host() -> NavigationHost:
	# You can customize this logic as needed
	for node in get_tree().get_nodes_in_group("navigation_host"):
		return node
	return null

# Push a new scene to the current navigation host
func push(name: StringName):
	var host = get_current_host()
	if host:
		host.push(name)

# Pop the current scene from the navigation host
func pop():
	var host = get_current_host()
	if host:
		host.pop()
