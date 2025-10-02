extends DragStrategy
class_name PectoDragStrat

@export_enum("Unit", "Offsite") var slotType : int = 0

func can_insert_card(card3D: PectoCard3D, to_collection: CardCollection3D, _from_collection: CardCollection3D) -> bool:
    if !to_collection.cards.is_empty(): return false
    if slotType != card3D.card.type: return false
    return true