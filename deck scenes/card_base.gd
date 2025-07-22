extends Area3D

@export var element: String = ""
var owner_type: String = ""

var mesh: MeshInstance3D
var base_material: Material
var highlight_material: Material
var last_click_time := 0.0

var label_3d : Label3D

# Guarda estado original do mesh
var original_scale: Vector3
var original_position: Vector3

# Valores para hover (aumentar escala e subir no eixo Z local do mesh)
var hover_scale: Vector3 = Vector3(2, 2, 2)
var hover_z_offset := 1.5

func _ready():
	if get_parent().name == "player_hand":
		owner_type = "player"
	else:
		owner_type = "npc"
	
	label_3d = $Label3D
	label_3d.text = element.capitalize() + " card"
	label_3d.visible = false  # começa oculto

	mesh = $MeshInstance3D
	base_material = mesh.get_active_material(0)

	if base_material == null:
		push_error("❌ Nenhum material encontrado na superfície 0!")
		return

	# cria o material destacado
	highlight_material = base_material.duplicate()
	highlight_material.emission_enabled = true
	highlight_material.emission = Color(1, 1, 0) * 0.5
	highlight_material.emission_energy_multiplier = 1.0

	original_scale = mesh.scale
	original_position = mesh.position

	connect("mouse_entered", _on_mouse_entered)
	connect("mouse_exited", _on_mouse_exited)

func _on_mouse_entered():
	if owner_type != "player":
		return
	print("Hover sobre carta: ", element)
	mesh.material_override = highlight_material
	mesh.scale = hover_scale
	mesh.position.z = original_position.z + hover_z_offset
	label_3d.visible = true

func _on_mouse_exited():
	if owner_type != "player":
		return
	print("Saiu de cima da carta: ", element)
	mesh.material_override = base_material
	mesh.scale = original_scale
	mesh.position = original_position
	label_3d.visible = false

func _input_event(camera, event, click_position, click_normal, shape_idx):
	if owner_type != "player":
		return

	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
		if GameState.played_card:
			return

		var now = Time.get_ticks_msec() / 1000.0
		if now - last_click_time < 0.3:
			# Duplo clique: jogar carta
			play_card()
			return
		else:
			last_click_time = now

		# Clique simples: abrir painel de descrição
		show_card_details()

		if GameState.selected_card and GameState.selected_card != self:
			GameState.selected_card.unhighlight()

		highlight()
		GameState.selected_card = self

func highlight():
	mesh.material_override = highlight_material

func unhighlight():
	mesh.material_override = base_material

func play_card():
	print("Jogou carta: ", element)
	GameState.played_card = true
	GameState.player_played_card = self
	GameState.selected_card = null
	GameState.player_card_type = ""
	global_position = Vector3(0.166, 0.559, 0.579)
	unhighlight()
	return element

func show_card_details():
	var panel = get_tree().get_root().get_node("main/CanvasCard/CardDetailPanel")
	if panel:
		panel.show_card(mesh.get_active_material(0).albedo_texture, "Descrição da carta: " + element.capitalize())
	else:
		push_error("❌ CardDetailPanel não encontrado na cena!")
