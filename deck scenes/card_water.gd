extends MeshInstance3D

@export var element: String = "water"
var owner_type: String = "" # player ou npc

var base_material : Material
var highlight_material : Material

func _ready():
	# Detecta owner automaticamente
	if get_parent().name == "player_hand":
		owner_type = "player"
	else:
		owner_type = "npc"

	# Guarda materiais
	base_material = material_override
	highlight_material = base_material.duplicate()
	highlight_material.emission_enabled = true
	highlight_material.emission = Color(1, 1, 0) * 0.5
	highlight_material.emission_energy_multiplier = 1.0

	# Adiciona colisor caso não exista
	if not has_node("CollisionShape3D"):
		var col = CollisionShape3D.new()
		col.shape = BoxShape3D.new()
		col.shape.size = mesh.get_aabb().size
		add_child(col)
		col.name = "CollisionShape3D"

func _input_event(camera, event, click_position, click_normal, shape_idx):
	if owner_type != "player":
		return

	if event is InputEventMouseMotion:
		material_override = highlight_material
		print("Hover sobre carta: ", element)
	elif event is InputEventMouseButton and event.is_pressed():
		print("Clique na carta: ", element)

func _unhandled_input(event):
	if owner_type != "player":
		return

	if event is InputEventMouseMotion:
		var space_state = get_world_3d().direct_space_state

		var ray_origin = get_viewport().get_camera_3d().project_ray_origin(event.position)
		var ray_end = ray_origin + get_viewport().get_camera_3d().project_ray_normal(event.position) * 1000

		var query = PhysicsRayQueryParameters3D.new()
		query.from = ray_origin
		query.to = ray_end
		query.exclude = [self]

		var result = space_state.intersect_ray(query)

		if result.is_empty():
			material_override = base_material
