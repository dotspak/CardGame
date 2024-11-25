@icon("res://assets/icons/spellIcon.svg")
extends Card
class_name SpellCard

enum SpellType {Normal, Instant, Effect, Passive}

@export_group("Stats")
@export var type : SpellType = SpellType.Normal
@export var uses : int = 0

func can_cast() -> bool: return true

func type_toString() -> String: return "S"