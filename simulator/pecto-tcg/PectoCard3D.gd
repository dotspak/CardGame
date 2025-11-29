extends Card3D
class_name PectoCard3D

@onready var frontFace : SubViewport = %frontFace
@onready var backFace : SubViewport = %backFace
@onready var anim : AnimationPlayer = $AnimationPlayer
@onready var iconAnim : AnimationPlayer = $iconAnimator

var card : PectoCard
var collection : CardCollection3D
var collectionIDX : int
var controller : PectoBoard3D

func _ready():
	%frontFace.render_target_update_mode = SubViewport.UPDATE_ALWAYS
	%frontFace.render_target_update_mode = SubViewport.UPDATE_ONCE
	%forcceIcon.hide()
	%lvlIcon.hide()


func set_front_face(_card : PectoCard) -> void:
	if !is_node_ready(): await ready
	card = _card
	frontFace.call_deferred("add_child", card)
	card.activeStatusChanged.connect(active_anim)
	card.enter.connect(_on_enter)


func _on_enter(_card : PectoCard) -> void:
	%enterParticles.emitting = true


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

	if card.banished:
		var mat : StandardMaterial3D = %lvlIcon.material_overlay
		mat.set("albedo_color", PectoCard.BANISHED_COLOR)
		%lvlLabel.outline_modulate = PectoCard.BANISHED_COLOR * 0.2
		%lvlLabel.modulate = PectoCard.BANISHED_COLOR

	iconAnim.play("display")
	await iconAnim.animation_finished
	iconAnim.play("loop")
	

func hide_icons() -> void:
	iconAnim.play_backwards("display")
	await iconAnim.animation_finished
	%forcceIcon.hide()
	%lvlIcon.hide()


func attack() -> void:
	var coord : Vector2 = controller.get_card_coord(self)
	var opponent : PectoBoard3D = GameManager.gameScene.get_opponent(controller)
	var targets : Array[Node] = []

	# middle row attack logic
	if coord.x == 1:
		print("handling a middle row unit attack")
		for i in range(3):
			var t : PectoCard3D = opponent.get_card(Vector2(i, 0))
			if t: targets.append(t)

		# checks if the opposing middle row is open
		if !opponent.get_card(coord):
			targets.append(opponent)
			for i in range(3):
				var t : PectoCard3D = opponent.get_card(Vector2(i, 1))
				if t: targets.append(t)
	
	# standard attack logic
	else:
		print("handling a standard unit attack")
		targets.append(opponent.get_card(coord))

		# first pass checks if a unit was found
		if targets.is_empty:
			targets.pop_front()
			coord.y = 1

			if !card.has_keyword("Sealed"): targets.append(opponent)
			targets.append(opponent.get_card(coord))
	
	if targets.is_empty(): return

	# bring up targetting menu
	var finalTarget : Node = targets[0]
	if targets.size() > 1:
		finalTarget = await GameManager.gameScene.select_card_target(targets)
	
	if !finalTarget: return

	anim.play("attack")
	await anim.animation_finished
	card.attack_card(finalTarget)
	card.active = false


func make_active() -> void: card.active = true
func make_inactive() -> void: card.active = false


func use_skill() -> void:
	card.active = false


func active_anim(status : bool) -> void:
	if !status: anim.play("inactive")
	else: anim.play_backwards("inactive")

func get_lvl() -> int: return card.lvl
