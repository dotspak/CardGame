extends Control

var slideSpeed : float = 0.3

func _process(_delta):
	$Label.text = "Cards Remaining " + str($pack.get_child_count())

func _on_next_card_button_pressed() -> void:
	show_next_card()

func show_next_card() -> void:
	var target : Node = $pack.get_child($pack.get_child_count() - 1)
	var TW : Tween = create_tween().set_ease(Tween.EASE_IN)
	target.reparent($shown)

	TW.tween_property(target, 
		"position:y", target.position.y - 50, 
		slideSpeed).set_trans(Tween.TRANS_BACK)
	TW.tween_property(target, 
		"modulate", Color(Color.WHITE,0), 
		slideSpeed / 2).set_trans(Tween.TRANS_QUAD)
