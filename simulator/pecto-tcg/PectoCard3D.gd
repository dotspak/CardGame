extends Card3D
class_name PectoCard3D

@onready var frontFace = %frontFace
@onready var backFace = %backFace
@onready var anim : AnimationPlayer = $AnimationPlayer
@onready var iconAnim : AnimationPlayer = $iconAnimator

var card : PectoCard
var collection : CardCollection3D
var collectionIDX : int

func _ready():
	%forcceIcon.hide()
	%lvlIcon.hide()


func set_front_face(_card : PectoCard) -> void:
	if !is_node_ready(): await ready
	card = _card
	frontFace.call_deferred("add_child", card)


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
	iconAnim.play("display")
	await iconAnim.animation_finished
	iconAnim.play("loop")
	

func hide_icons() -> void:
	iconAnim.play_backwards("display")
	await iconAnim.animation_finished
	%forcceIcon.hide()
	%lvlIcon.hide()


func attack() -> void:
	anim.play("attack")
	await anim.animation_finished
	card.active = false
	anim.play("inactive")


func use_skill() -> void:
	card.active = false
	anim.play("inactive")
