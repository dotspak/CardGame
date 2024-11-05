extends GPUParticles2D

const basic = preload("res://assets/particleMaterials/basicMaterial.tres")
const rare = preload("res://assets/particleMaterials/rareMaterial.tres")
const sRare = preload("res://assets/particleMaterials/superMaterial.tres")
const dRare = preload("res://assets/particleMaterials/divineMaterial.tres")

func spawn(rarity : int) -> void:
    match(rarity):
        0: 
            process_material = basic
            amount = 25
        1:
            process_material = rare
            amount = 50
        2:
            process_material = sRare
            amount = 100
        3:
            process_material = dRare
            amount = 200
    
    emitting = true
    await finished
    queue_free()