extends CardCollection3D
class_name GridSlot

var board : PectoBoard3D

@export_enum("Unit", "Offsite") var type : int = 0
@export var linkedSlot : MeshInstance3D
var defaultColor : Color

func _ready():
	if linkedSlot:
		await linkedSlot.ready
		var material : StandardMaterial3D = get_slot_mat()
		defaultColor = material.albedo_color


func highlight_slot() -> void:
	if !linkedSlot: return
	var material : StandardMaterial3D = get_slot_mat()
	var tween := create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
	var color : Color = Color.LIGHT_YELLOW.lerp(defaultColor, 0.5)
	tween.tween_property(material, "albedo_color", color, 0.1)


func unhighlight_slot() -> void:
	if !linkedSlot: return
	var material : StandardMaterial3D = get_slot_mat()
	var tween := create_tween().set_trans(Tween.TRANS_SINE)
	tween.tween_property(material, "albedo_color", defaultColor, 0.1)


func get_slot_mat() -> StandardMaterial3D:
	if !linkedSlot: return null
	return linkedSlot.get_active_material(0)


func _on_card_moved(_card: Variant, _from: Variant, _to: Variant) -> void: drag_strategy.can_select = false
func _on_card_added(_card: Variant) -> void:
	#await get_tree().create_timer(0.1).timeout
	drag_strategy.can_select = true
