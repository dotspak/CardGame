@tool
@icon("uid://fwr4di8poij3")
extends Node
class_name PectoCard

const DB_PATH : String = "res://data/pectoDB.db"

@export var ID : String = "" : ## reference to the database's Primary Key for retrieving data
	set(val): 
		ID = val
		ID = ID.replace(" ", "_").to_upper()

@export var table : String = "set1"
@export_tool_button("Retrieve Data")
var sqlButton = update_db
var db : SQLite

func update_db() -> void:
	if ID == "":
		push_error("ID not set!")
		return
	
	var tableRef : String = "pecto_" + table

	db = SQLite.new()
	db.path = DB_PATH
	db.open_db()

	db.query("""
		CREATE TABLE IF NOT EXISTS %s (
			ID TEXT PRIMARY KEY,
			name TEXT,
			type TEXT,
			rarity TEXT,
			force INTEGER,
			lvl INTEGER)""" % tableRef)

	db.query_with_bindings("SELECT * FROM %s WHERE ID=?;" % tableRef, [ID])

	# insert new entry into database
	if db.query_result.size() <= 0:
		db.query_with_bindings("""
			INSERT INTO %s (ID, name, type, rarity, force, lvl)
			VALUES (?, ?, ?, ?, ?, ?)""" % tableRef, 
			[ID, cardName, type, rarity, force, lvl])
		print("added card ", cardName, " to database at:", str(ID))

	# update existing entry
	else:
		db.query_with_bindings("""
			UPDATE %s
			SET name=?, type=?, rarity=?, force=?, lvl=? 
			WHERE ID=?""" % tableRef,
		[cardName, type, rarity, force, lvl, ID])
		print("updated card ", cardName, " at:", str(ID))

	db.close_db()
	
	
#region Data
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

const SKILL_COLOR : Color = Color("e44298")
const FSKILL_COLOR : Color = Color("16a98fff")

const KEYWORD_COLOR : Color = Color.ORANGE

enum CARD_TYPE{Unit, Offsite, Spell}

enum TRIBE{
	Ghost, Golem, Wizard, Monster, 
	Magic, God, Warrior, Celestial,
	Bug, Object, Old, Plague, Rat,
	Dark, Structure, Shapeshifter, 
	Crow, Marlita, Bee, Queen, 
	Equipment, Field}

enum KEYWORD{Instant, Effect,
	Flying, Static, Bleed, Sealed, Quick,
	Delayed, Sick, Fragile, Immortal, Doom,}

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
			%cardType.visible = type != CARD_TYPE.Spell
			match type:
				CARD_TYPE.Unit:
					%cardTypeIcon.texture = UNIT_ICON
					%border.self_modulate = UNIT_COLOR
					%textContainer.self_modulate = UNIT_COLOR
					%skillContainer.self_modulate = UNIT_COLOR
					%nameContainer.self_modulate = UNIT_COLOR
					
				CARD_TYPE.Offsite:
					%cardTypeIcon.texture = OFFSITE_ICON
					%border.self_modulate = OFFSITE_COLOR
					%textContainer.self_modulate = OFFSITE_COLOR
					%skillContainer.self_modulate = OFFSITE_COLOR
					%nameContainer.self_modulate = OFFSITE_COLOR
					
				CARD_TYPE.Spell:
					%cardTypeIcon.texture = SPELL_ICON
					%border.self_modulate = SPELL_COLOR
					%textContainer.self_modulate = SPELL_COLOR
					%skillContainer.self_modulate = SPELL_COLOR
					%nameContainer.self_modulate = SPELL_COLOR
				
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
		
@export var lvl : int = 1 :
	set(val):
		lvl = val
		if is_node_ready():
			%cardLVL.text = str(lvl)
		
@export var banished : bool = false :
	set(val):
		banished = val
		if is_node_ready():
			%lvlIcon.modulate = Color("ff7e87") if banished else Color.WHITE

@export var tribe : Array[TRIBE] :
	set(val):
		tribe = val
		if is_node_ready():
			%cardType.text = ""
			for t : TRIBE in tribe: %cardType.text += TRIBE.keys()[t] + " "
			%cardType.text.strip_edges()
			%cardType.visible = %cardType.text != ""

@export var keywords : Array[KEYWORD] = [] :
	set(val):
		keywords = val
		if is_node_ready():
			%cardKeywords.text = "[i][color=%s]"%KEYWORD_COLOR.to_html()
			
			for i : int in keywords.size():
				var k : KEYWORD = keywords[i]
				%cardKeywords.text += KEYWORD.keys()[k]
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
			var material : ShaderMaterial = %cardArt.material
			material.set_shader_parameter("intensity", 0.4 if foil else 0.0)

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
#endregion

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
			var icon : String = TEXT_TAGS[tag]["icon"]
			var color : String = TEXT_TAGS[tag]["color"]
			replacement = "[bgcolor=%s][b]%s%s[/b][/bgcolor]" % [color, icon, value]

		output = output.substr(0, m.get_start()) + replacement + output.substr(m.get_end())
	return output


#region setters
func set_force(newForce : int = 1) -> void: force = newForce
func change_force(amount : int = 1) -> void: force += amount

func set_lvl(newLVL : int = 1) -> void: lvl = newLVL
func change_lvl(amount : int = 1) -> void: lvl += amount
#endregion