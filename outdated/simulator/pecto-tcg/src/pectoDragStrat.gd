extends DragStrategy
class_name PectoDragStrat

@export var playEnabled : bool = true

func can_insert_card(card3D: PectoCard3D, to_collection: CardCollection3D, from_collection: CardCollection3D) -> bool:
	if can_remove:
		# movement phase logic
		var swapCard : PectoCard3D
		if !to_collection.cards.is_empty(): swapCard = to_collection.cards[0]
		if swapCard:
			if !can_swap_cards(card3D, to_collection.cards[0]):
				return false
	else:
		# from hand logic
		if from_collection is GridSlot: return false
		if card3D.card.lvl > to_collection.get_player().get_highest_playable(): return false
		if !to_collection.cards.is_empty(): return false

	return playEnabled


func can_swap_cards(cardToMove : PectoCard3D, prevCard : PectoCard3D) -> bool:
	return !prevCard || (
		cardToMove.card.active && !cardToMove.card.has_keyword("static") && cardToMove.card.type != PectoCard.CARD_TYPE.Spell &&
		prevCard.card.active && !prevCard.card.has_keyword("static") && cardToMove.card.type != PectoCard.CARD_TYPE.Spell)


func movement_phase_mode() -> void:
	can_remove = true

func exit_movement_phase_mode() -> void:
	can_remove = false


func enable_play() -> void: playEnabled = true
func disable_play() -> void: playEnabled = false
