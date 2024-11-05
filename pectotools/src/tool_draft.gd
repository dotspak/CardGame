extends Control

@onready var packNum : LineEdit = $PackRollText/TextEdit

# when the button is pressed, roll the cards
func _on_button_pressed() -> void:
	for n : Node in $packs.get_children(): 
		n.text = ""
	for i in int(packNum.text):
		var textField : RichTextLabel = find_child("packs").find_child(str(i+1))
		var drafter : Drafter = Drafter.new()
		var pack : Array[Card] = drafter.generate_pack(false)
		for s : String in drafter.pack_toString(pack):
			textField.text += s
