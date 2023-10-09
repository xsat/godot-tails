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
		$Tails/Tail0, $Tails/Tail1, $Tails/Tail2, 
		$Tails/Tail3, $Tails/Tail4, $Tails/Tail5, 
		$Tails/Tail6, $Tails/Tail7, $Tails/Tail8,
	]
	
func _on_tail_variant_select(tail_variant: TailVariant) -> void:
	if !tails[next_tail_position].visible:
		tails[next_tail_position].visible = true
	else:
		_add_to_game_score(-1)
		
	tails[next_tail_position].symbol.text = tail_variant.text
	
	if next_tail_position >= tails.size() - 1:
		next_tail_position = 0
	else:
		next_tail_position += 1
	
	tail_variant.text = _generate_random_symbol()
	
	while _is_delete_victory_tails():
		_add_to_game_score(3)
	
func _generate_random_symbol() -> String:
	return tail_symbols.pick_random()
	
func _is_delete_victory_tails() -> bool:
	if _is_same_values(tails[0], tails[1], tails[2]):
		_remove_victory_tails(tails[0], tails[1], tails[2])
		
		return true
		
	if _is_same_values(tails[3], tails[4], tails[5]):
		_remove_victory_tails(tails[3], tails[4], tails[5])
		
		return true
		
	if _is_same_values(tails[6], tails[7], tails[8]):
		_remove_victory_tails(tails[6], tails[7], tails[8])
		
		return true
		
	if _is_same_values(tails[0], tails[3], tails[6]):
		_remove_victory_tails(tails[0], tails[3], tails[6])
		
		return true
		
	if _is_same_values(tails[1], tails[4], tails[7]):
		_remove_victory_tails(tails[1], tails[4], tails[7])
		
		return true
		
	if _is_same_values(tails[2], tails[5], tails[8]):
		_remove_victory_tails(tails[2], tails[5], tails[8])
		
		return true
		
	if _is_same_values(tails[0], tails[4], tails[8]):
		_remove_victory_tails(tails[0], tails[4], tails[8])
		
		return true
		
	if _is_same_values(tails[6], tails[4], tails[2]):
		_remove_victory_tails(tails[6], tails[4], tails[2])
		
		return true
		
	return false
		
func _is_same_values(first_tail: Tail, second_tail: Tail, third_tail: Tail) -> bool:
	if !first_tail.visible || !second_tail.visible || !third_tail.visible:
		return false
	
	return first_tail.symbol.text == second_tail.symbol.text && second_tail.symbol.text == third_tail.symbol.text 
	
func _add_to_game_score(added_value: int) -> void:
	game_score += added_value
	score.text = "%s" % game_score
	
func _remove_victory_tails(first_tail: Tail, second_tail: Tail, third_tail: Tail) -> void:
	first_tail.visible = false
	second_tail.visible = false
	third_tail.visible = false
	
