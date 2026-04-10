@icon("res://assets/icons/unitIcon.svg")
extends Card
class_name UnitCard

enum RemoveType {Discard, Sacrifice, Destroy}

@export_group("stats")
@export var force : int = 1
@export var bonus : int = 0
@export var shield : bool = false
@export var infect : int = 0

var active : bool = true
var firstTurn : bool = true

signal removeCard(tag : RemoveType) 

# logic for attacking another card
func attack(target : UnitCard) -> void:
    target.take_damage(calculate_damage())
    take_damage(target.calculate_damage())

# logic for taking damage 
func take_damage(dmg : int) -> void:
    if !shield:
        force = max(0, force - dmg)
        if force <= 0: remove_card()
    else:
        shield = false

# calculates the damage
func calculate_damage() -> int: return force + bonus
func remove_card(tag : RemoveType = RemoveType.Destroy) -> void: removeCard.emit(tag)

# booleans
func can_attack() -> bool: return active && !firstTurn
func can_move() -> bool: return active
func can_use_skills() -> bool: return active

func type_toString() -> String: return "U"