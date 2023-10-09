extends ColorRect

class_name Tail

@onready var symbol: Label = $Symbol as Label

@export var symbol_text: String

func _ready() -> void:
	if symbol_text:
		symbol.text = symbol_text
