extends TweenBasedNavEntryTransition
class_name FadeOutTransition

func start(entry: NavigationEntry):
	var tween = entry.create_tween()
	tween.tween_property(entry, "modulate:a", 0, duration)
	tween.set_ease(easing)
	tween.set_trans(transition)
	await tween.finished
	entry.visible = false
	entry.modulate.a = 1
	
