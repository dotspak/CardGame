extends Resource
class_name Card

@export var name : String = "Greater Crow"
@export_enum("Unit", "Off-Site", "Spell") var type : int = 0
@export_enum("Basic", "Rare", "Super-Rare", "Divine-Rare") var rarity : int = 0