extends Button

class_name TailVariant

signal select(TailVariant)

func _on_pressed() -> void:
	select.emit(self)
