extends Area3D

@export var element: String = "earth"
var owner_type: String = ""

var mesh: MeshInstance3D
var base_material: Material
var highlight_material: Material

func _ready():
	if get_parent().name == "player_hand":
		owner_type = "player"
	else:
		owner_type = "npc"

	mesh = $MeshInstance3D
	base_material = mesh.material_override

	# cria o material destacado
	highlight_material = base_material.duplicate()
	highlight_material.emission_enabled = true
	highlight_material.emission = Color(1, 1, 0) * 0.5  # cor amarelada suave
	highlight_material.emission_energy_multiplier = 1.0
	
	connect("mouse_entered", _on_mouse_entered)
	connect("mouse_exited", _on_mouse_exited)

func _on_mouse_entered():
	if owner_type != "player":
		return
	print("Hover sobre carta: ", element)
	mesh.material_override = highlight_material

func _on_mouse_exited():
	if owner_type != "player":
		return
	print("Saiu de cima da carta: ", element)
	mesh.material_override = base_material
