extends Card3D
class_name PectoCard3D

@onready var frontFace = %frontFace
@onready var backFace = %backFace

var card : PectoCard

func set_front_face(_card : PectoCard) -> void:
	if !is_node_ready(): await ready
	card = _card
	frontFace.call_deferred("add_child", card)
	#card.get_child(0).scale = Vector2.ONE * 0.5
