extends DragStrategy
class_name PectoDragStrat

@export_enum("Unit", "Offsite") var slotType : int = 0

func can_insert_card(card3D: PectoCard3D, to_collection: CardCollection3D, from_collection: CardCollection3D) -> bool:
	# checks if card is already on the board
	if from_collection.name != "Hand":
		if card3D.card.type == PectoCard.CARD_TYPE.Offsite: return false
		if card3D.card.has_keyword("static"): return false
		if !card3D.card.active: return false

	# basic card stat checks
	if card3D.card.lvl > to_collection.board.get_influence(): return false
	if slotType != card3D.card.type: return false
	
	# check if space is empty
	if !to_collection.cards.is_empty(): return false
		#if from_collection.name == "Hand": return false
		#elif !card3D.card.active: return false
		#else: return can_swap_cards(card3D, to_collection.cards[0])

	to_collection.highlight_slot()

	return true


func can_swap_cards(cardToMove, prevCard) -> bool: return cardToMove.card.active && !prevCard.card.has_keyword("static")
