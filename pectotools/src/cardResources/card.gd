extends Resource
class_name Card

enum Keyword {
    # unit keywords
    Flying, Static, Fragile, Bleed, Agile, Haste, Defender, FirstStrike, Sidestep,
    
    # off-site keywords
    Totem, Organic, Stadium
}

enum Rarity {B, R, SR, DR}

@export_group("info")
@export var name : String = ""
@export var cost : String = "0"
@export var rarity : Rarity = Rarity.B
@export var img : Texture2D
@export_multiline var description : String
@export var keywords : Array[Keyword]

func rarity_toString() -> String: return Rarity.keys()[rarity]
func type_toString() -> String: return ""