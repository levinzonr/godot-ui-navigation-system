extends TweenBasedNavEntryTransition
class_name SlideInTransition

@export_range(0, 1) var leave_fraction: float = 0.5


func start(entry: NavigationEntry):
	entry.offset_left = entry.size.x * leave_fraction
	entry.visible = true
	var tween = entry.create_tween()
	tween.tween_property(entry, "offset_left", 0, duration)
	tween.set_trans(transition)
	tween.set_ease(easing)
	await tween.finished
