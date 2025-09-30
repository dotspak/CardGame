@tool
extends Node
class_name PectoCard

@export var PKEY : String = "" ## reference to the database's Primary Key for retrieving data
@export_tool_button("Retrieve Data")
var button = call_db

func call_db() -> void:
	print("hasn't been added yet!")
	
#region Data
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

enum KEYWORD{ Instant, Effect,
	Flying, Static, Bleed, Sealed, Quick,
	Delayed, Sick, Fragile, Immortal, Doom,}
#endregion

#region Visual
@export_group("Visual")
@export var type : CARD_TYPE = CARD_TYPE.Unit : 
	set(val):
		type = val
		if is_node_ready():
			%force.visible = type != CARD_TYPE.Spell
			%cardType.visible = type != CARD_TYPE.Spell
			match type:
				CARD_TYPE.Unit:
					%cardTypeIcon.texture = UNIT_ICON
					$bg/visual/border.self_modulate = UNIT_COLOR
					$bg/visual/border/MarginContainer/text/textContainer.self_modulate = UNIT_COLOR
					$bg/visual/border/MarginContainer/text/skillContainer.self_modulate = UNIT_COLOR
					$bg/visual/topBar/info/nameContainer.self_modulate = UNIT_COLOR
					
				CARD_TYPE.Offsite:
					%cardTypeIcon.texture = OFFSITE_ICON
					$bg/visual/border.self_modulate = OFFSITE_COLOR
					$bg/visual/border/MarginContainer/text/textContainer.self_modulate = OFFSITE_COLOR
					$bg/visual/border/MarginContainer/text/skillContainer.self_modulate = OFFSITE_COLOR
					$bg/visual/topBar/info/nameContainer.self_modulate = OFFSITE_COLOR
					
				CARD_TYPE.Spell:
					%cardTypeIcon.texture = SPELL_ICON
					$bg/visual/border.self_modulate = SPELL_COLOR
					$bg/visual/border/MarginContainer/text/textContainer.self_modulate = SPELL_COLOR
					$bg/visual/border/MarginContainer/text/skillContainer.self_modulate = SPELL_COLOR
					$bg/visual/topBar/info/nameContainer.self_modulate = SPELL_COLOR
				
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
		
@export var skillName : String = "":
	set(val):
		skillName = val
		if is_node_ready():
			update_skill_box()
			#$bg/visual/border/MarginContainer/text/skillContainer.visible = skillName != ""
			#var wrapped : String = "{fskill:%s}"%skillName if isSkillContinuous else "{skill:%s}"%skillName
			#%skillName.text = parse_card_text(wrapped).strip_edges()
			

@export_multiline var skillText : String = "Dummy text goes here!" :
	set(val):
		skillText = val
		if is_node_ready():
			update_skill_box()
			#var parsed : String = parse_card_text(skillText).strip_edges()
			#%cardSkill.text = parsed
			
@export var isSkillContinuous : bool = false:
	set(val):
		isSkillContinuous = val
		skillName = skillName
		if is_node_ready():
			$bg/visual/border/MarginContainer/text/skillContainer/bg.modulate = SKILL_COLOR \
			if !isSkillContinuous else FSKILL_COLOR
			
			#$bg/visual/border/MarginContainer/text/skillContainer/MarginContainer/VBoxContainer/skillName/grad.modulate = SKILL_COLOR \
			#if !isSkillContinuous else FSKILL_COLOR
#endregion

#region Logic
@export_group("Logic")
@export var cardLogicNode : Node
@export var skill : Node
#endregion

func set_force(newForce : int = 1) -> void: force = newForce
func change_force(amount : int = 1) -> void: force += amount

func set_lvl(newLVL : int = 1) -> void: lvl = newLVL
func change_lvl(amount : int = 1) -> void: lvl += amount

func update_skill_box() -> void:
	$bg/visual/border/MarginContainer/text/skillContainer.visible = skillName != ""
	%cardSkill.text = ""
	
	var sn : String = "{fskill:%s}"%skillName if isSkillContinuous else "{skill:%s}"%skillName
	%cardSkill.text = parse_card_text(sn).strip_edges() + " "
	%cardSkill.text += parse_card_text(skillText).strip_edges()
	

var TEXT_TAGS : Dictionary = {
	"trigger": {"color" : "orange", "icon" : "➥"},
	"skill" : {"color" : SKILL_COLOR.to_html(), "icon" : "★"},
	"fskill" : {"color" : FSKILL_COLOR.to_html(), "icon" : "★"},
	"force" : {"color" : "e44298", "icon" : ""}
}

func parse_card_text(text : String) -> String:
	var output : String = text
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
			replacement = "[bgcolor=%s]%s%s[/bgcolor]" % [color, icon, value]

		output = output.substr(0, m.get_start()) + replacement + output.substr(m.get_end())
	return output
