extends Area3D

@export var element: String = "air"
var owner_type: String = ""

var mesh: MeshInstance3D
var base_material: Material
var highlight_material: Material
var last_click_time := 0.0

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

func _input_event(camera, event, click_position, click_normal, shape_idx):
	if owner_type != "player":
		return

	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		if GameState.played_card:
			# já jogou uma carta, não pode selecionar mais
			return

		var now = Time.get_ticks_msec() / 1000.0  # segundos
		if now - last_click_time < 0.3:
			# double click detectado
			play_card()
			return
		else:
			last_click_time = now

		if GameState.selected_card and GameState.selected_card != self:
			# deseleciona a anterior
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
	GameState.selected_card = null
	# move para a área da mesa
	global_position = Vector3(0.166, 0.559, 0.579)  # ajuste para sua posição alvo
	# opcional: impedir highlight
	unhighlight()

	
