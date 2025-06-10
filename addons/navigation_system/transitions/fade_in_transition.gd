extends TweenBasedNavEntryTransition
class_name FadeInTransition

func start(entry: NavigationEntry):
	entry.modulate.a = 0
	entry.visible = true
	var tween = entry.create_tween()
	tween.tween_property(entry, "modulate:a", 1, duration)
	tween.set_ease(easing)
	tween.set_trans(transition)
	await tween.finished
