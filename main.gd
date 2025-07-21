extends Node3D

@onready var player_hand := $player_hand
@onready var npc_hand = $npc_hand
@onready var end_turn_button := $CanvasLayer/EndTurnButton
@onready var merge_button = $CanvasLayer2/MergeButton

#Import basic elements_cards
var player_deck_elements = ["fire", "water", "earth", "air"]
var npc_deck_elements = ["fire", "water", "earth", "air"]

#import secondary cards
@onready var card_base_scene := preload("res://deck scenes/card_base.tscn")

@onready var card_textures = {
	# bases
	"fire": preload("res://assets/cards-assets/base_cards/20_Element_Fire.png"),
	"water": preload("res://assets/cards-assets/base_cards/23_Element_Water.png"),
	"earth": preload("res://assets/cards-assets/base_cards/25_Element_Earth.png"),
	"air": preload("res://assets/cards-assets/base_cards/22_Element_Air.png"),
	
	# secondary
	"sand": preload("res://assets/cards-assets/secondary_cards/Element_Sand.png"),
	"lightning": preload("res://assets/cards-assets/secondary_cards/Element_Lightning.png"),
	"mist": preload("res://assets/cards-assets/secondary_cards/Element_Mist.png"),
	"magma": preload("res://assets/cards-assets/secondary_cards/Element_Magma.png"),
	"clay": preload("res://assets/cards-assets/secondary_cards/Element_Clay.png"),
	"steam": preload("res://assets/cards-assets/secondary_cards/Element_Steam.png")
}

const FUSION_TABLE = {
	# Basic
	["air", "earth"]: "sand",
	["earth", "air"]: "sand",
	
	["fire","air"]: "lightining",
	["air", "fire"]: "lightning",
	
	["water","air"]:"mist",
	["air", "water"]: "mist",
	
	["fire","earth"]: "magma",
	["earth", "fire"]: "magma",
	
	["water","earth"]: "clay",
	["earth", "water"]: "clay",
	
	["water","fire"]: "steam",
	["fire", "water"]: "steam",

	# Secondary + basic = terciary
	["lightning", "earth"]: "magnetite",
	["lightning", "water"]: "charged mist",
	["magma", "air"]: "glass",
	["magma", "water"]: "basalt",
	["vapor", "earth"]: "geyser",
	["vapor", "air"]: "smoke",
	["sand", "fire"]: "ash",
	["sand", "water"]: "mud",
	["clay", "fire"]: "brick",
	["clay", "air"]: "sand",
	["mist", "earth"]: "swamp",
	["mist", "fire"]: "steam",

	# sec + sec = terciary
	["glass", "lightning"]: "radiance",
	["magnetite", "vapor"]: "engine",
	["clay", "lightning"]: "animated golem",
	["mist", "dust"]: "frosted glass",
	["magma", "clay"]: "obsidian",

	# Sec + terc = quaternary
	["sand", "mist"]: "frost",
	["sand", "vapor"]: "fog",
	["sand", "magma"]: "cinders",
	["glass", "vapor"]: "mirror",
	["glass", "sand"]: "stained glass",
	["magma", "lightning"]: "stormstone",
	["clay", "smoke"]: "idol",
	["magma", "clay"]: "ceramic",
	["vapor", "mist"]: "cloud",
	["glass", "smoke"]: "dark mirror",

	# terc + basic = quaternary
	["radiance", "earth"]: "crystal",
	["radiance", "water"]: "prism",
	["radiance", "air"]: "halo",
	["radiance", "fire"]: "solar flame",
	["obsidian", "water"]: "shard",
	["obsidian", "air"]: "blade",
	["engine", "fire"]: "furnace",
	["engine", "water"]: "mill",
	["animated golem", "air"]: "spirit golem",
	["animated golem", "earth"]: "guardian",
	["frosted glass", "fire"]: "tears of glass"
}

func _ready():

	_initialize_hand(player_hand, player_deck_elements, _get_player_start_positions())
	_initialize_hand(npc_hand, npc_deck_elements, _get_npc_start_positions())
	
	end_turn_button.visible = false
	end_turn_button.connect("pressed", _on_end_turn_pressed)
	
	merge_button.visible = false
	merge_button.connect("pressed", _on_merge_pressed)


func _process(delta):
	if GameState.played_card and not end_turn_button.visible:
		end_turn_button.visible = true

func _on_end_turn_pressed():
	print("Jogador finalizou turno!")

	var player_card = GameState.player_played_card
	if not player_card:
		print("Nenhuma carta do jogador encontrada")
		return

	var npc_cards = npc_hand.get_children()
	if npc_cards.is_empty():
		print("NPC não tem cartas")
		return

	# tentar escolher uma carta diferente da do player
	var npc_card = null
	for card in npc_cards:
		if card.element != player_card.element:
			npc_card = card
			break

	if npc_card == null:
		print("NPC só tem cartas iguais — turno inválido")
		return

	npc_card.global_position = Vector3(-0.100, 0.559, 0.579)
	GameState.npc_played_card = npc_card

	merge_button.visible = true
	end_turn_button.disabled = true


func _on_merge_pressed():
	print("Fusão iniciada!")

	var player_card = GameState.player_played_card
	var npc_card = GameState.npc_played_card

	if not player_card or not npc_card:
		print("Cartas para fusão não encontradas")
		return

	# impedir fusão de cartas iguais
	if player_card.element == npc_card.element:
		print("Cartas iguais! Não é possível fundir: ", player_card.element)
		# devolver as cartas para as mãos
		_reset_card(player_card, player_hand)
		_reset_card(npc_card, npc_hand)

		# resetar estado
		GameState.played_card = false
		end_turn_button.visible = false
		end_turn_button.disabled = false
		merge_button.visible = false
		return

	var elements_pair = [player_card.element, npc_card.element]

	if not FUSION_TABLE.has(elements_pair):
		print("Fusão inválida para elementos: ", elements_pair)
		# devolver as cartas para as mãos
		_reset_card(player_card, player_hand)
		_reset_card(npc_card, npc_hand)

		# resetar estado
		GameState.played_card = false
		end_turn_button.visible = false
		end_turn_button.disabled = false
		merge_button.visible = false
		return

	var result_element = FUSION_TABLE[elements_pair]
	print("Fusão resultou em: ", result_element)

	# eliminar as cartas usadas
	player_card.queue_free()
	npc_card.queue_free()

	# instanciar nova carta para cada deck
	_add_card_to_hand(player_hand, result_element)
	_add_card_to_hand(npc_hand, result_element)



	# resetar estado
	GameState.played_card = false
	end_turn_button.visible = false
	end_turn_button.disabled = false
	merge_button.visible = false

func _reset_card(card: Node3D, hand: Node3D):
	card.global_position = hand.global_position
	card.reparent(hand)

func _add_card_to_hand(hand: Node3D, element: String):
	var card = card_base_scene.instantiate()
	var mesh = card.get_node("MeshInstance3D")
	var mat = mesh.get_active_material(0).duplicate()
	
	mesh.set_surface_override_material(0, mat)

	if mat and card_textures.has(element):
		mat.albedo_texture = card_textures[element]
	else:
		print("⚠️ Textura não encontrada para: ", element)

	hand.add_child(card)
	card.global_position = position
# escolher posição livre
	var positions = _get_player_start_positions() if hand == player_hand else _get_npc_start_positions()
	var used_positions = []
	for child in hand.get_children():
		used_positions.append(child.global_position)

	for pos in positions:
		var found = false
		for used in used_positions:
			if pos.is_equal_approx(used):
				found = true
				break
		if not found:
			card.global_position = pos
			return

	# fallback: se não encontrar posição livre
	card.global_position = hand.global_position
	print("⚠️ Nenhuma posição livre para adicionar carta.")


func _initialize_hand(hand_node: Node3D, elements: Array, start_positions: Array):
	for i in range(elements.size()):
		var element = elements[i]
		var card = card_base_scene.instantiate()
		card.element = element

		var mesh = card.get_node("MeshInstance3D")
		var mat = mesh.get_active_material(0).duplicate()
		mesh.set_surface_override_material(0, mat)

		if mat and card_textures.has(element):
			mat.albedo_texture = card_textures[element]
		else:
			print("⚠️ Textura não encontrada para: ", element)


		hand_node.add_child(card)

		# Posição inicial (opcional: você pode definir um array com as posições ou calcular dinamicamente)
		if i < start_positions.size():
			card.position = start_positions[i]


func _get_player_start_positions():
	return [
		Vector3(0.96, 0.559, 0.065),
		Vector3(0.814, 0.559, 0.065),
		Vector3(0.668, 0.559, 0.065),
		Vector3(0.515, 0.559, 0.065)
	]

func _get_npc_start_positions():
	return [
		Vector3(-0.468, 0.559, 0.065),
		Vector3(-0.785, 0.559, 0.065),
		Vector3(-0.628, 0.559, 0.065),
		Vector3(-0.971, 0.559, 0.065)
	]
