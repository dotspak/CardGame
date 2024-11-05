extends Control

var slideSpeed : float = 0.3
var pack : Array[Card]
var remCards : int
var drafter : Drafter = Drafter.new()

const particles : PackedScene = preload("res://assets/particleMaterials/rarityParticles.tscn")
const cardBack : PackedScene = preload("res://assets/cardBack.tscn")

@onready var bg : ColorRect = $CanvasLayer/ColorRect
@onready var cam : Camera2D = $Camera2D
var shakeStr : float = 0

func _ready() -> void: 
	bg.color = Color("a6b4d9")
	pack = drafter.generate_pack()
	drafter.save_to_txtFile(drafter.pack_toString(pack))
	for c : Card in pack:
		var vCard : VisualCard = VisualCard.new(c)
		$pack.add_child(vCard)
	$pack.add_child(cardBack.instantiate())

func _process(_delta): 
	remCards = $pack.get_child_count()
	if remCards > 0:
		if $pack.get_child(remCards - 1) is VisualCard:
			$Label.text = $pack.get_child(remCards - 1).card.name
	else:
		$Label.text = "Did you get good pulls?"
		$nextCardButton.text = "Open New Pack"

	cam.offset = Vector2(randf_range(-shakeStr, shakeStr), randf_range(-shakeStr, shakeStr))

func _on_next_card_button_pressed() -> void:
	if $pack.get_child_count() > 0:
		show_next_card()
	else:
		get_tree().reload_current_scene()

func show_next_card() -> void:
	var target : Node = $pack.get_child(remCards - 1)
	var TW : Tween = create_tween().set_ease(Tween.EASE_IN).set_parallel()
	target.reparent($shown)

	TW.tween_property(target, 
		"position:y", target.position.y - 100, 
		slideSpeed).set_trans(Tween.TRANS_BACK)
	TW.tween_property(target,
		"scale", Vector2(0.7,0.7), slideSpeed)

	TW.tween_property(target, 
		"modulate", Color(Color.WHITE,0), 
		slideSpeed * 2).set_trans(Tween.TRANS_QUAD)
	
	await get_tree().create_timer(0.3).timeout

	if $pack.get_child_count() > 0:
		card_effect($pack.get_child(remCards - 1))
	else:
		display_full_pack()

func display_full_pack() -> void:
	for n : Node in $shown.get_children():
		if n is VisualCard:
			var TW : Tween = create_tween()
			n.reparent($displayResult)
			TW.tween_property(n, "modulate", Color.WHITE, slideSpeed)
	
func card_effect(vc : VisualCard) -> void:
	# spawn particles
	var rarity : int = vc.card.rarity
	var p : GPUParticles2D = particles.instantiate()
	add_child(p)
	move_child(p, 0)
	p.spawn(rarity)

	shake_cam(0.7 * rarity, 0.2 * rarity)

	var shiftColor : Color
	match(rarity):
		0:
			shiftColor = Color("a6b4d9")
		1:
			shiftColor = Color("e6a56d")
		2:
			shiftColor = Color("e794d7")
		3:
			shiftColor = Color("e33b2b")
	create_tween().tween_property(bg, "color", shiftColor, 0.2)

func shake_cam(strength : float, dur : float) -> void:
	shakeStr = strength
	await get_tree().create_timer(dur).timeout
	shakeStr = 0