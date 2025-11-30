@tool
@icon("uid://b0psj1ihvfcu6")
extends Control
class_name PectoCard

const TEMPLATE_SCENE : String = "res://scenes/cardTemplates/card_visuals.tscn"

#region Data
var db : Dictionary
var data : Dictionary

@export_group("Data")
@export var ID : String = "" ## reference to the database's card ID for retrieving data
@export_tool_button("Update Card")
var updateButton = func():
	PectoCard.get_card_data(self)
	update_card_data(true)

@export_tool_button("Reset Card")
var resetButton = reset_card_data

enum CARD_TYPE{Unit, Icon, Spell, Token}
enum RARITY{Basic, Rare, Superrare, Divinerare}

#endregion

#region Visual
var cardVisuals : CardVisuals

@export_group("info")
@export var type : CARD_TYPE = CARD_TYPE.Unit : 
	set(val):
		type = val
		update_card_visuals()
				
@export var cardName : String = "Abstract Wizard" :
	set(val):
		cardName = val
		update_card_visuals()

@export var force : int = 1 :
	set(val):
		force = val
		update_card_visuals()

@export_range(0, 99) var lvl : int = 1 :
	set(val):
		lvl = clamp(val, 0, 99)
		update_card_visuals()

@export var subtype : Array :
	set(val):
		subtype = val
		update_card_visuals()

@export var keywords : Array = [] :
	set(val):
		keywords = val
		update_card_visuals()
		
@export_multiline var text : String = "Dummy text goes here!" :
	set(val):
		text = val
		update_card_visuals()
		
@export var skillName : String = "":
	set(val):
		skillName = val
		update_card_visuals()

@export_multiline var skillText : String = "Dummy text goes here!" :
	set(val):
		skillText = val
		update_card_visuals()

@export var isSkillContinuous : bool = false:
	set(val):
		isSkillContinuous = val
		update_card_visuals()
			
@export_group("visual")
@export var art : Texture:
	set(val):
		art = val
		update_card_visuals()
			
@export var bg : Texture :
	set(val):
		bg = val
		update_card_visuals()
			
@export var foil : bool = false:
	set(val):
		foil = val
		update_card_visuals()

@export var rarity : RARITY = RARITY.Basic:
	set(val):
		rarity = val
		update_card_visuals()

@export var shadowColor : Color = Color("6f6f6f") :
	set(val):
		shadowColor = val
		update_card_visuals()

@export_enum("multiply", "screen", "darken", "lighten", "difference",
	"exclusion", "overlay", "hard_light", "soft_light",
	"color_dodge", "linear_dodge", "color_burn", "linear_burn") var shadowBlendMode : int = 0 :
		set(val):
			shadowBlendMode = val
			update_card_visuals()
	
#endregion

#region Logic
@export_group("Logic")
@export var cardLogicNode : Node
@export var skill : Node

signal enter(card : PectoCard)
signal victor(card : PectoCard, target : Node)
signal perish(card : PectoCard, condition : String)
signal activeStatusChanged(status : bool)

var inPlay : bool = false
var active : bool = true :
	set(val):
		if val != active:
			active = val
			activeStatusChanged.emit(active)

func _ready():
	custom_minimum_size = Vector2(750, 1050)
	PectoCard.get_card_data(self)
	update_card_data(Engine.is_editor_hint())
	spawn_card_template()


func spawn_card_template() -> void:
	for n in get_children():
		if n is CardVisuals:
			n.queue_free()
			break
	cardVisuals = load(TEMPLATE_SCENE).instantiate()
	add_child(cardVisuals)
	update_card_visuals()


func _enter() -> void:
	inPlay = true
	enter.emit(self)
	
	if keywords.has("delayed"): active = false
	else: active = true


func _perish(condition : String) -> void:
	perish.emit(self, condition)
	_exit()


func _exit() -> void:
	inPlay = false


func _victor(target : Node) -> void:
	victor.emit(self, target)


func attack_card(target : Node) -> void:
	if target is PectoBoard3D:
		if target.has_method("deal_damage"):
			target.deal_damage(force)
			return attack_aftermath(target)

	var target_startForce : int = target.force
	var self_startForce : int = force

	# this card attacks target
	if !has_keyword("bleed"): target.deal_damage(self_startForce)
	else: target.force = 0

	# target deals damage back
	if !has_keyword("quick") || target.force > 0:
		if !target.has_bleed(): deal_damage(target_startForce)
		else: force = 0

	attack_aftermath(target)


func attack_aftermath(target : Node) -> void:
	if has_keyword("fragile"): force = 0
	else: _victor(target)

	if target is PectoCard:
		if target.force > 0:
			if target.has_keyword("fragile"): target.force = 0
			else: target._victor(self)


func deal_damage(amount : int) -> void: force -= amount
func heal_damage(amount : int) -> void: force += amount
func has_keyword(key : String) -> bool: return keywords.has(key)
#endregion

#region functions
static func get_card_data(card : PectoCard) -> Dictionary:
	var retrieved : Dictionary = {}
	var msg : String = ""
	card.db = {}

	if card.ID == "": 
		msg = "Card ID is invalid!"
	else:
		if Engine.is_editor_hint():
			var DB_PATH : String = "res://data/pectoDB.json"
			if FileAccess.file_exists(GameManager.DB_PATH):
				var file : FileAccess = FileAccess.open(DB_PATH, FileAccess.READ)
				card.db = JSON.parse_string(file.get_as_text())
			else:
				printerr("File Doesn't Exist!")
		else:
			card.db = GameManager.DB

		# data has been found, see if the card exists in it
		if card.db:
			if card.db["cards"].keys().has(card.ID):
				retrieved = card.db["cards"][card.ID]
				msg = "Data retrieved successfully!"
	print(msg)
	print(retrieved)
	card.data = retrieved
	return card.data


func update_card_data(_updateScenePath : bool = false) -> void:
	cardName = data["name"]
	type = data["type"]
	subtype = data["subtype"]

	lvl = data["lvl"]
	force = data["force"]

	keywords = data["keywords"]
	text = data["text"]

	if data["skill"]:
		var skillData : Dictionary = db["skills"][data["skill"]]
		skillName = skillData["name"]
		skillText = skillData["text"]
		isSkillContinuous = skillData["type"]

	if FileAccess.file_exists("res://assets/set1/" + data["art"]):
		art = load("res://assets/set1/" + data["art"])


func reset_card_data() -> void:
	ID = ""
	
	cardName = "Dummy"
	type = CARD_TYPE.Unit
	subtype = []

	lvl = 1
	force = 0

	keywords = []
	text = "insert dummy text here!"

	skillName = ""
	skillText = ""
	isSkillContinuous = false

	art = null

func update_card_visuals() -> void:
	var visuals : CardVisuals = cardVisuals
	if !visuals: return
	
	visuals.type = type
	visuals.cardName = cardName

	visuals.force = force
	visuals.lvl = lvl

	visuals.subtype = subtype
	visuals.keywords = keywords
	visuals.text = text

	visuals.skillName = skillName
	visuals.skillText = skillText
	visuals.isSkillContinuous = isSkillContinuous

	visuals.art = art
	visuals.bg = bg
	visuals.shadowColor = shadowColor
	visuals.shadowBlendMode = shadowBlendMode

#endregion


#region setters
func set_force(newForce : int = 1) -> void: force = newForce
func change_force(amount : int = 1) -> void: force += amount
func set_lvl(newLVL : int = 1) -> void: lvl = newLVL
func change_lvl(amount : int = 1) -> void: lvl += amount
#endregion

#region getters
func get_card_text() -> String: return cardVisuals.get_card_text()
func get_card_keyword_text() -> String: return cardVisuals.get_card_keyword_text()
func get_card_skill() -> String: return cardVisuals.get_card_skill()
func get_card_name() -> String: return cardVisuals.get_card_name()
func get_card_art() -> Texture: return cardVisuals.get_card_art()
func get_card_types() -> PackedStringArray: return cardVisuals.get_card_types()
#endregion
