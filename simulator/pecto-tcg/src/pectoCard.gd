@tool
@icon("uid://b0psj1ihvfcu6")
extends Control
class_name PectoCard

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

const BASIC_ICON : Texture = preload("uid://dmhctqok0ncxr")
const RARE_ICON : Texture = preload("uid://db7a3ny4orsly")
const SUPERRARE_ICON : Texture = preload("uid://b7pbscney3tcv")
const DIVINERARE_ICON : Texture = preload("uid://d1kafd45aa4e")

const UNIT_ICON : Texture = preload("uid://de5nr31l6262q")
const UNIT_COLOR : Color = Color("b869aa")

const OFFSITE_ICON : Texture = preload("uid://brxxnkd348fxh")
const OFFSITE_COLOR : Color = Color("ffc114ff")

const SPELL_ICON : Texture = preload("uid://b613u8p8qy5pc")
const SPELL_COLOR : Color = Color("1a92ceff")

const TOKEN_ICON : Texture = preload("uid://imigtnoksj5i")
const TOKEN_COLOR : Color = Color("aaaaaaff")

const SKILL_COLOR : Color = Color("e44298")
const FSKILL_COLOR : Color = Color("16a98fff")

const KEYWORD_COLOR : Color = Color.ORANGE

enum CARD_TYPE{Unit, Icon, Spell, Token}

enum RARITY{Basic, Rare, Superrare, Divinerare}
	
var TEXT_TAGS : Dictionary = {
	"trigger": {"color" : "orange", "icon" : "➥"},
	"skill" : {"color" : SKILL_COLOR.to_html(), "icon" : "★"},
	"fskill" : {"color" : FSKILL_COLOR.to_html(), "icon" : "★"},
	"force" : {"color" : "e44298", "icon" : ""}}
#endregion

#region Visual
@export_group("info")
@export var type : CARD_TYPE = CARD_TYPE.Unit : 
	set(val):
		type = val
		if is_node_ready():
			%force.visible = type != CARD_TYPE.Spell
			%rarity.visible = type != CARD_TYPE.Token
			
			var colorAndIcon : Array = [[UNIT_ICON,UNIT_COLOR],[OFFSITE_ICON,OFFSITE_COLOR],[SPELL_ICON,SPELL_COLOR],[TOKEN_ICON,TOKEN_COLOR]]
			%cardTypeIcon.texture = colorAndIcon[type][0]
			%border.self_modulate = colorAndIcon[type][1]
			%textContainer.self_modulate = colorAndIcon[type][1]
			%skillContainer.self_modulate = colorAndIcon[type][1]
			%nameContainer.self_modulate = colorAndIcon[type][1]

			update_type_label()
				
@export var cardName : String = "Abstract Wizard" :
	set(val):
		cardName = val
		if is_node_ready():
			%cardName.text = cardName
			%cardName.text.strip_edges()

@export var force : int = 1 :
	set(val):
		force = val
		if is_node_ready():
			%cardForce.text = str(force)
		
@export_range(0, 99) var lvl : int = 1 :
	set(val):
		lvl = clamp(val, 0, 99)
		if is_node_ready():
			%cardLVL.text = str(lvl)

@export var subtype : Array :
	set(val):
		subtype = val
		update_type_label()

@export var keywords : Array = [] :
	set(val):
		keywords = val
		if is_node_ready():
			%cardKeywords.text = "[i][color=%s]"%KEYWORD_COLOR.to_html()
			
			for i : int in keywords.size():
				var key : String = keywords[i]
				keywords[i] = key.to_lower()
				%cardKeywords.text += key.capitalize()
				if i < keywords.size() - 1:
					%cardKeywords.text += ", "
				
			%cardKeywords.text.strip_edges()
		
@export_multiline var text : String = "Dummy text goes here!" :
	set(val):
		text = val
		if is_node_ready():
			var parsed : String = parse_card_text(text).strip_edges()
			%cardText.text = parsed
			%textContainer.visible = parsed != ""
		
@export var skillName : String = "":
	set(val):
		skillName = val
		if is_node_ready():
			update_skill_box()

@export_multiline var skillText : String = "Dummy text goes here!" :
	set(val):
		skillText = val
		if is_node_ready():
			update_skill_box()

@export var isSkillContinuous : bool = false:
	set(val):
		isSkillContinuous = val
		skillName = skillName
		if is_node_ready():
			%skillBG.modulate = SKILL_COLOR \
			if !isSkillContinuous else FSKILL_COLOR
			
@export_group("visual")
@export var art : Texture:
	set(val):
		art = val
		if is_node_ready():
			%cardArt.texture = art
			
@export var bg : Texture :
	set(val):
		bg = val
		if is_node_ready():
			%cardBackground.texture = bg
			
@export var foil : bool = false:
	set(val):
		foil = val
		if is_node_ready():
			var m : ShaderMaterial = %cardArt.material
			m.set_shader_parameter("intensity", 0.4 if foil else 0.0)

@export var rarity : RARITY = RARITY.Basic:
	set(val):
		rarity = val
		if is_node_ready():
			var texture : Texture
			match rarity:
				RARITY.Basic: texture = BASIC_ICON
				RARITY.Rare: texture = RARE_ICON
				RARITY.Superrare: texture = SUPERRARE_ICON
				RARITY.Divinerare: texture = DIVINERARE_ICON
			%rarity.texture = texture

const CORNER_RADIUS : int = 48
@export var roundedEdges : bool = true:
	set(val):
		roundedEdges = val
		if is_node_ready():
			var stylebox : StyleBoxFlat = %cardShape.get("theme_override_styles/panel")
			stylebox.corner_radius_bottom_left = CORNER_RADIUS if roundedEdges else 0
			stylebox.corner_radius_bottom_right = CORNER_RADIUS if roundedEdges else 0
			stylebox.corner_radius_top_left = CORNER_RADIUS if roundedEdges else 0
			stylebox.corner_radius_top_right = CORNER_RADIUS if roundedEdges else 0

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
	PectoCard.get_card_data(self)
	update_card_data(Engine.is_editor_hint())

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
func update_skill_box() -> void:
	%skillContainer.visible = skillName != ""
	%cardSkill.text = ""
	
	var sn : String = "{fskill:%s}"%skillName if isSkillContinuous else "{skill:%s}"%skillName
	%cardSkill.text = parse_card_text(sn).strip_edges() + " "
	%cardSkill.text += parse_card_text(skillText).strip_edges()


func parse_card_text(string : String) -> String:
	var output : String = string
	var regex : RegEx = RegEx.new()
	regex.compile(r"\{([a-zA-Z]+):([^}]+)\}")
	
	var matches : Array[RegExMatch] = regex.search_all(output)
	
	for i : int in range(matches.size() -1, -1, -1):
		var m = matches[i]
		var tag : String = m.get_string(1).to_lower()
		var value : String = m.get_string(2).to_upper()
		var replacement : String = m.get_string(0)
		
		if TEXT_TAGS.has(tag):
			if tag != "force":
				var icon : String = TEXT_TAGS[tag]["icon"]
				var color : String = TEXT_TAGS[tag]["color"]
				replacement = "[bgcolor=%s][b]%s%s[/b][/bgcolor]" % [color, icon, value]
			else:
				var color : String = TEXT_TAGS[tag]["color"]
				replacement = "[bgcolor=%s][b] %s [/b][/bgcolor]" % [color, value]

		output = output.substr(0, m.get_start()) + replacement + output.substr(m.get_end())
	return output


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


func update_card_data(updateScenePath : bool = false) -> void:
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

	# set scene path for the given card
	if updateScenePath:
		var scenePath : String = get_tree().edited_scene_root.scene_file_path
		if scenePath == "" || scenePath == "res://scenes/cardTemplates/card_pectoCard.tscn":
			print("No scene path (unsaved scene). Skipping scenepath update.")
			return
		
		db["cards"][ID]["scenepath"] = scenePath

		var file := FileAccess.open("res://data/pectoDB.json", FileAccess.WRITE)
		if file:
			file.store_string(JSON.stringify(db, "\t"))
			file.close()
			print("Database saved to ", "res://data/pectoDB.json")
		else:
			push_error("Failed to save card DB to: " + "res://data/pectoDB.json")



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


func update_type_label() -> void:
	if !is_node_ready(): return
	var subtypeText : String = ""
	for s : String in subtype: subtypeText += s + " "

	%cardType.text = subtypeText
	%cardType.text.strip_edges()
	%cardType.visible = %cardType.text != ""


func enter_set_mode() -> void:
	%bottomInfo.hide()
	%topBar.hide()
	%extraInfo.hide()


func enter_full_mode() -> void:
	%bottomInfo.show()
	%topBar.show()
	%extraInfo.show()

#endregion


#region setters
func set_force(newForce : int = 1) -> void: force = newForce
func change_force(amount : int = 1) -> void: force += amount
func set_lvl(newLVL : int = 1) -> void: lvl = newLVL
func change_lvl(amount : int = 1) -> void: lvl += amount
#endregion

func get_card_text() -> String: return %cardText.text
func get_card_keyword_text() -> String: return %cardKeywords.text.strip_edges()
func get_card_skill() -> String: return %cardSkill.text if skillName != "" else ""
func get_card_name() -> String: 
	return %cardName.text + " " + "[bgcolor=%s][b] %s [/b][/bgcolor]" % \
		[Color("e44298").to_html(), force] + \
		"/" + "[color=%s]LVL: %s" % [Color.WHITE.to_html(), lvl]
func get_card_art() -> Texture: return art
func get_card_types() -> PackedStringArray: 
	var types : PackedStringArray = []
	var t : String = %cardType.text.to_lower()
	var r : RegEx = RegEx.new()
	r.compile("[^a-zA-Z]+")
	t = r.sub(t, " ", true)
	types = t.split(" ", false)
	return types
