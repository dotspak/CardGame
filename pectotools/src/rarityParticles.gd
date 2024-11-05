extends GPUParticles2D

func spawn(rarity : int) -> void:
    match(rarity):
        0: 
            process_material = load("res://assets/particleMaterials/basicMaterial.tres")
            amount = 25
        1:
            process_material = load("res://assets/particleMaterials/rareMaterial.tres")
            amount = 50
        2:
            process_material = load("res://assets/particleMaterials/superMaterial.tres")
            amount = 100
        3:
            process_material = load("res://assets/particleMaterials/divineMaterial.tres")
            amount = 200
    
    emitting = true
    await finished
    queue_free()