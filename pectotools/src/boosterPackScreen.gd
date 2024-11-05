extends Control

var slideSpeed : float = 0.3
var pack : Array[Card]
var remCards : int
var drafter : Drafter = Drafter.new()

const particles : PackedScene = preload("res://assets/particleMaterials/rarityParticles.tscn")
const cardBack : PackedScene = preload("res://assets/cardBack.tscn")

func _ready() -> void: 
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
		$Label.text = ""

func _on_next_card_button_pressed() -> void:
	show_next_card()

func show_next_card() -> void:
	var target : Node = $pack.get_child(remCards - 1)
	var TW : Tween = create_tween().set_ease(Tween.EASE_IN)
	target.reparent($shown)

	TW.tween_property(target, 
		"position:y", target.position.y - 50, 
		slideSpeed).set_trans(Tween.TRANS_BACK)
	TW.tween_property(target, 
		"modulate", Color(Color.WHITE,0), 
		slideSpeed / 2).set_trans(Tween.TRANS_QUAD)
	
	await get_tree().create_timer(0.3).timeout

	if $pack.get_child_count() > 0:
		card_effect($pack.get_child(remCards - 1))
	
func card_effect(vc : VisualCard) -> void:
	# spawn particles
	var p : GPUParticles2D = particles.instantiate()
	add_child(p)
	move_child(p, 0)
	p.spawn(vc.card.rarity)
