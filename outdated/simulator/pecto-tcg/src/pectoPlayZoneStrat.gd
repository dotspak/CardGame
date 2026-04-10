extends DragStrategy
class_name PectoPlayZoneStrat

@export var playEnabled : bool = true

func can_insert_card(card : PectoCard3D, _to_collection: CardCollection3D, from_collection: CardCollection3D) -> bool:
	can_select = card.card.type == 2 \
		&& from_collection.name == "Hand" \
		&& GameManager.playerBoards[0].lvl >= card.card.lvl
	return can_select

func enable_play() -> void: playEnabled = true
func disable_play() -> void: playEnabled = false