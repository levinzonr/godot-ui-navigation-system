extends TweenBasedNavEntryTransition
class_name SlideOutTransition

@export_range(0, 1) var leave_fraction: float = 0.5

func start(entry: NavigationEntry):
	var tween = entry.create_tween()
	tween.tween_property(entry, "offset_left", entry.size.x * leave_fraction, duration)
	tween.set_ease(easing)
	tween.set_trans(transition)
	await tween.finished
	entry.visible = false
	entry.offset_left = 0
