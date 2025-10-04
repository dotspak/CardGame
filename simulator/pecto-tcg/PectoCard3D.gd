extends Card3D
class_name PectoCard3D

@onready var frontFace = %frontFace
@onready var backFace = %backFace

var card : PectoCard
var collection : CardCollection3D
var collectionIDX : int

func set_front_face(_card : PectoCard) -> void:
	if !is_node_ready(): await ready
	card = _card
	frontFace.call_deferred("add_child", card)
	#card.get_child(0).scale = Vector2.ONE * 0.5

func _click(_camera, event : InputEvent, _event_position, _normal, _shape_idx):
	if event is InputEventMouseButton:
		var button = event.button_index
		var pressed = event.pressed
		if button == 1 and pressed == true:
			card_3d_mouse_down.emit()
		elif button == 1 and pressed == false:
			card_3d_mouse_up.emit()

func display_icons() -> void:
	%forcceIcon.get_child(0).text = str(card.force)
	%lvlIcon.get_child(0).text = str(card.lvl)
	%forcceIcon.show()
	%lvlIcon.show()

func hide_icons() -> void:
	%forcceIcon.hide()
	%lvlIcon.hide()