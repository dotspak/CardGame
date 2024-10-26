extends Node

enum CARD_TYPE { UNIT, OFF_SITE, SPELL }
enum RARITY { BASIC, RARE, SUPER_RARE, DIVINE_RARE}

const rareColors : Array[String] = [ "FFFFFF", "FFAA00", "FFAAFF", "FF0000" ]

@export_category("Card Types")
@export var units : Array[Card] = []
@export var spells : Array[Card] = []
@export var offSites : Array[Card] = []

# sorted database of cards
var database : Dictionary = {
	"U" : {"B": [], "R": [], "SR": [], "DR" : []},
	"O" : {"B" : [], "R": [], "SR": [], "DR": []},
	"S" : { "B" : [], "R": [], "SR": [], "DR": []}
}

# converts between data types
const rarity_to_string : Dictionary = { 0 : "B", 1 : "R", 2 : "SR", 3 : "DR" }
const type_to_string : Dictionary = { 0 : "U", 1 : "O", 2 : "S" }

const rarity_to_int : Dictionary = { "B" : 0, "R" : 1, "SR" : 2, "DR" : 3 }
const type_to_int : Dictionary = { "U" : 0, "O" : 1, "S" : 2}


func _ready() -> void:
	_init_database()

# sorts the raw data of each card into the database
func _init_database() -> void:
	var iterations : int = units.size()
	if spells.size() > iterations: iterations = spells.size()
	if offSites.size() > iterations: iterations = offSites.size()

	reset_database()

	for i : int in iterations:
		if i < units.size(): store_card_in_database(units[i])
		if i < spells.size(): store_card_in_database(spells[i])
		if i < offSites.size(): store_card_in_database(offSites[i])

# resets the database
func reset_database() -> void:
	database.clear()
	database = {
		"U" : {"B": [], "R": [], "SR": [], "DR" : []},
		"O" : {"B" : [], "R": [], "SR": [], "DR": []},
		"S" : { "B" : [], "R": [], "SR": [], "DR": []} }

# stores a card in its respective slot in the databaes
func store_card_in_database(card : Card) -> void:
	var type : String = type_to_string[card.type]
	var rarity : String = rarity_to_string[card.rarity]
	database[type][rarity].append(card)

# returns a duplicate of a newly initalized database
func instance_database() -> Dictionary:
	_init_database()
	return database.duplicate()

# returns a random card from the database
static func rand_search(data : Dictionary, type : int = 0, rarity : int = RARITY.BASIC) -> Card:
	var result : Array = data[
		Database.type_to_string[type]][
			Database.rarity_to_string[rarity]]
	result.shuffle()
	return result[0]