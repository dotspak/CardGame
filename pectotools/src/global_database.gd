extends Node

enum CARD_TYPE { UNIT, OFF_SITE, SPELL }
enum RARITY { BASIC, RARE, SUPER_RARE, DIVINE_RARE}

@export var rareColors : Array[String] = [ "FFFFFF", "FFAA00", "FFAAFF", "FF0000" ]
@export var database : Dictionary = {
	"Unit" : {"Basic": [], "Rare": [], "Super-Rare": [], "Divine-Rare" : []},
	"Off-Site" : {"Basic" : [], "Rare": [], "Super-Rare": [], "Divine-Rare": []},
	"Spell" : { "Basic" : [], "Rare": [], "Super-Rare": [], "Divine-Rare": []}
}

func rand_search(type : int = 0, rarity : int = RARITY.BASIC) -> Card:
	return database[type_to_string(type)][rarity_to_string(rarity)].duplicate().shuffle()

# converts ints into readale strings
func rarity_to_string(r : int) -> String:
	match r:
		0: return "Basic"
		1: return "Rare"
		2: return "Super-Rare"
		3: return "Divine-Rare"
	return "Basic"
	
func type_to_string(t : int) -> String:
	match t:
		0: return "Unit"
		1: return "Off-Site"
		2: return "Spell"
	return "Unit"