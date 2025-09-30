@tool
extends RichTextEffect
class_name TriggerEffect

var bbcode = "trigger"

@export var colorA : Color = Color("f37123ff")
@export var colorB : Color = Color("ffc114ff")

func _process_custom_fx(char_fx: CharFXTransform) -> bool:
	var t : float = 1 - 0.1 * char_fx.relative_index
	var finalColor : Color = colorB.lerp(colorA, t)
	char_fx.color = finalColor
	return true
