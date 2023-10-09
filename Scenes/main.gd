extends Node

class_name Main

const NONE_TAIL_POSITION: int = -1

var tail_symbols: Array[String] = ["@", "#", "$", "%", "&", "="]

var tail_variants: Array[TailVariant]

var tails: Array[Tail]

var current_tail_position: int = NONE_TAIL_POSITION

func _ready() -> void:
	tail_variants = [
		$Variants/TailVariant1,
		$Variants/TailVariant2,
		$Variants/TailVariant3,
	]
	
	for tail_variant in tail_variants:
		tail_variant.select.connect(_on_tail_variant_select)
		
	_regenerate_tail_variants()
		
	tails = [
		$Tails/Tail1, $Tails/Tail2, $Tails/Tail3, 
		$Tails/Tail4, $Tails/Tail5, $Tails/Tail6, 
		$Tails/Tail7, $Tails/Tail8, $Tails/Tail9,
	]
	
func _on_tail_variant_select(tail_variant: TailVariant) -> void:
	print(tail_variant.text)
	
func _regenerate_tail_variants() -> void:
	for tail_variant in tail_variants:
		tail_variant.text = _generate_random_symbol()
	
func _generate_random_symbol() -> String:
	return tail_symbols.pick_random()
