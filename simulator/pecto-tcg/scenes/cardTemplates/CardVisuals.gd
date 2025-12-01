@tool
extends Control
class_name CardVisuals

const TEXT_SIZE : int = 30

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

enum RARITY{Basic, Rare, Superrare, Divinerare}
	
var TEXT_TAGS : Dictionary = {
	"trigger": {"color" : "orange", "icon" : "➥"},
	"skill" : {"color" : SKILL_COLOR.to_html(), "icon" : "★"},
	"fskill" : {"color" : FSKILL_COLOR.to_html(), "icon" : "★"},
	"force" : {"color" : "e44298", "icon" : ""},
	"key" : {"color" : KEYWORD_COLOR.to_html(), "icon" : ""}}

#region Variables
var type : int = 0 : 
	set(val):
		type = val
		if is_node_ready():
			%force.visible = type != 2
			%rarity.visible = type != 3
			
			var colorAndIcon : Array = [[UNIT_ICON,UNIT_COLOR],[OFFSITE_ICON,OFFSITE_COLOR],[SPELL_ICON,SPELL_COLOR],[TOKEN_ICON,TOKEN_COLOR]]
			%cardTypeIcon.texture = colorAndIcon[type][0]
			%border.self_modulate = colorAndIcon[type][1]
			%textContainer.self_modulate = colorAndIcon[type][1]
			%skillContainer.self_modulate = colorAndIcon[type][1]
			%nameContainer.self_modulate = colorAndIcon[type][1]

			update_type_label()
				
var cardName : String = "Dummy" :
	set(val):
		cardName = val
		if is_node_ready():
			%cardName.text = to_small_caps(cardName, 40, 28)
			%cardName.text.strip_edges()

var force : int = 1 :
	set(val):
		force = val
		if is_node_ready():
			%cardForce.text = str(force)
		
var lvl : int = 1 :
	set(val):
		lvl = clamp(val, 0, 99)
		if is_node_ready():
			%cardLVL.text = str(lvl)

var subtype : Array :
	set(val):
		subtype = val
		update_type_label()

var keywords : Array = [] :
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
		
var text : String = "Dummy text goes here!" :
	set(val):
		text = val
		if is_node_ready():
			var parsed : String = parse_card_text(text).strip_edges()
			%cardText.text = parsed
			%textContainer.visible = parsed != ""
		
var skillName : String = "":
	set(val):
		skillName = val
		if is_node_ready():
			update_skill_box()

var skillText : String = "Dummy text goes here!" :
	set(val):
		skillText = val
		if is_node_ready():
			update_skill_box()

var isSkillContinuous : bool = false:
	set(val):
		isSkillContinuous = val
		skillName = skillName
		if is_node_ready():
			%skillBG.modulate = SKILL_COLOR \
			if !isSkillContinuous else FSKILL_COLOR
			
var art : Texture:
	set(val):
		art = val
		if is_node_ready():
			%cardArt.texture = art
			
var bg : Texture :
	set(val):
		bg = val
		if is_node_ready():
			%cardBackground.texture = bg
			
var foil : bool = false:
	set(val):
		foil = val
		if is_node_ready():
			var m : ShaderMaterial = %cardArt.material
			m.set_shader_parameter("intensity", 0.4 if foil else 0.0)

var rarity : RARITY = RARITY.Basic:
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

var shadowColor : Color = Color("6f6f6f") :
	set(val):
		shadowColor = val
		update_shadow()

var shadowBlendMode : int = 0 :
	set(val):
		shadowBlendMode = val
		update_shadow()

#endregion

#region Functions

func update_type_label() -> void:
	if !is_node_ready(): return
	var subtypeText : String = ""
	for s : String in subtype: subtypeText += s + " "

	%cardType.text = subtypeText
	%cardType.text.strip_edges()
	%cardType.visible = %cardType.text != ""


func update_skill_box() -> void:
	%skillContainer.visible = skillName != ""
	%cardSkill.text = ""
	
	var sn : String = "{fskill:%s}"%skillName if isSkillContinuous else "{skill:%s}"%skillName
	%cardSkill.text = parse_card_text(sn).strip_edges() + " "
	%cardSkill.text += parse_card_text(skillText).strip_edges()


func update_shadow() -> void:
	var stylebox : StyleBoxFlat = %shadow.get_theme_stylebox("panel")
	stylebox.border_color = shadowColor
	%shadow.material.set_shader_parameter("mode", shadowBlendMode)


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
			if tag == "key":
				var kw = format_keywords_list(value)
				var color = TEXT_TAGS[tag]["color"]
				replacement = "[bgcolor=#00000088][color=%s][i]%s[/i][/color][/bgcolor]" % [color, kw]
			elif tag != "force":
				var icon : String = TEXT_TAGS[tag]["icon"]
				var color : String = TEXT_TAGS[tag]["color"]
				var sc = to_small_caps(value)
				replacement = "[bgcolor=%s][b]%s%s[/b][/bgcolor]" % [color, icon, sc]
			else:
				# handles force icons
				replacement = "[img=24]res://assets/forceBG.png[b]%s[/b][/img]" % [value]

		output = output.substr(0, m.get_start()) + replacement + output.substr(m.get_end())
	
	var ritualRegex : RegEx = RegEx.new()
	ritualRegex.compile(r"(RITUAL:)")
	output = ritualRegex.sub(output, "[bgcolor=f00]💀%s[/bgcolor]" % to_small_caps("RITUAL"))
	return output


func to_small_caps(string : String, bigSize : int = TEXT_SIZE, smallSize : int = TEXT_SIZE - 8) -> String:
	var words = string.strip_edges().to_upper().split(" ")
	var parts : Array = []
	for w in words:
		if w.length() <= 1:
			parts.append("[font_size=%d]%s[/font_size]" % [bigSize, w])
		else:
			var first = w[0]
			var rest = w.substr(1)
			parts.append("[font_size=%d]%s[/font_size][font_size=%d]%s[/font_size]" % [bigSize, first, smallSize, rest])
	return " ".join(parts)


func format_keywords_list(string : String) -> String:
	var items = string.split(",", false)
	var out : Array = []
	for item in items:
		item = item.strip_edges()
		if item.length() > 0:
			out.append(item.capitalize())
	return ", ".join(out)

#endregion

#region getters
func get_card_text() -> String: return %cardText.text
func get_card_keyword_text() -> String: return %cardKeywords.text.strip_edges()
func get_card_skill() -> String: return %cardSkill.text if skillName != "" else ""
func get_card_name() -> String: 
	return parse_card_text(
		%cardName.text + " " + "{force:%s}" % force + "/" 
		+ "[color=%s]LVL: %s" % [Color.WHITE.to_html(), lvl])
func get_card_art() -> Texture: return art
func get_card_types() -> PackedStringArray: 
	var types : PackedStringArray = []
	var t : String = %cardType.text.to_lower()
	var r : RegEx = RegEx.new()
	r.compile("[^a-zA-Z]+")
	t = r.sub(t, " ", true)
	types = t.split(" ", false)
	return types
#endregion