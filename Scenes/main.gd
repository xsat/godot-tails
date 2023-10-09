extends Node

class_name Main

@onready var score: Label = $Score as Label

var tail_symbols: Array[String] = ["@", "#", "$", "%", "&", "="]

var tail_variants: Array[TailVariant]

var tails: Array[Tail]

var next_tail_position: int = 0
var game_score: int = 10

func _ready() -> void:
	tail_variants = [
		$Variants/TailVariant1,
		$Variants/TailVariant2,
		$Variants/TailVariant3,
	]
	
	for tail_variant in tail_variants:
		tail_variant.select.connect(_on_tail_variant_select)
		tail_variant.text = _generate_random_symbol()
		
	tails = [
		$Tails/Tail1, $Tails/Tail2, $Tails/Tail3, 
		$Tails/Tail4, $Tails/Tail5, $Tails/Tail6, 
		$Tails/Tail7, $Tails/Tail8, $Tails/Tail9,
	]
	
func _on_tail_variant_select(tail_variant: TailVariant) -> void:
	if !tails[next_tail_position].visible:
		tails[next_tail_position].visible = true
	else:
		game_score -= 1
		score.text = "%s" % game_score
		
	tails[next_tail_position].symbol.text = tail_variant.text
	
	if next_tail_position >= tails.size() - 1:
		next_tail_position = 0
	else:
		next_tail_position += 1
	
	tail_variant.text = _generate_random_symbol()
	
func _generate_random_symbol() -> String:
	return tail_symbols.pick_random()
