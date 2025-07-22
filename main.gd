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
	"steam": preload("res://assets/cards-assets/secondary_cards/Element_Steam.png"),
	
	#third
	"ash": preload("res://assets/cards-assets/terciary_cards/Element_Ash.png"),
	"basalt": preload("res://assets/cards-assets/terciary_cards/Element_Basalt.png"),
	"brick": preload("res://assets/cards-assets/terciary_cards/Element_Brick.png"),
	"charged mist": preload("res://assets/cards-assets/terciary_cards/Element_ChargedMist.png"),
	"engine": preload("res://assets/cards-assets/terciary_cards/Element_Engine.png"),
	"frosted glass": preload("res://assets/cards-assets/terciary_cards/Element_FrostedGlass.png"),
	"geyser": preload("res://assets/cards-assets/terciary_cards/Element_Geyser.png"),
	"glass": preload("res://assets/cards-assets/terciary_cards/Element_Glass.png"),
	"golem": preload("res://assets/cards-assets/terciary_cards/Element_Golem.png"),
	"magnetite": preload("res://assets/cards-assets/terciary_cards/Element_Magnetite.png"),
	"mud": preload("res://assets/cards-assets/terciary_cards/Element_Mud.png"),
	"obsidian": preload("res://assets/cards-assets/terciary_cards/Element_Obsidian.png"),
	"radiance": preload("res://assets/cards-assets/terciary_cards/Element_Radiance.png"),
	"smoke": preload("res://assets/cards-assets/terciary_cards/Element_Smoke.png"),
	"swamp": preload("res://assets/cards-assets/terciary_cards/Element_Swamp.png"),
	
	#fourth
	"blade": preload("res://assets/cards-assets/quartenary_cards/Element_Blade.png"),
	"ceramic": preload("res://assets/cards-assets/quartenary_cards/Element_Ceramic.png"),
	"cinder": preload("res://assets/cards-assets/quartenary_cards/Element_Cinder.png"),
	"cloud": preload("res://assets/cards-assets/quartenary_cards/Element_Cloud.png"),
	"crystal": preload("res://assets/cards-assets/quartenary_cards/Element_Crystal.png"),
	"dark mirror": preload("res://assets/cards-assets/quartenary_cards/Element_DarkMirror.png"),
	"fog": preload("res://assets/cards-assets/quartenary_cards/Element_Fog.png"),
	"frost": preload("res://assets/cards-assets/quartenary_cards/Element_Frost.png"),
	"furnace": preload("res://assets/cards-assets/quartenary_cards/Element_Furnace.png"),
	"guardian": preload("res://assets/cards-assets/quartenary_cards/Element_Guardian.png"),
	"halo": preload("res://assets/cards-assets/quartenary_cards/Element_Halo.png"),
	"idol": preload("res://assets/cards-assets/quartenary_cards/Element_Idol.png"),
	"mill": preload("res://assets/cards-assets/quartenary_cards/Element_Mill.png"),
	"mirror": preload("res://assets/cards-assets/quartenary_cards/Element_Mirror.png"),
	"prism": preload("res://assets/cards-assets/quartenary_cards/Element_Prism.png"),
	"shard": preload("res://assets/cards-assets/quartenary_cards/Element_shard.png"),
	"solar flame": preload("res://assets/cards-assets/quartenary_cards/Element_SolarFlame.png"),
	"spirit golem": preload("res://assets/cards-assets/quartenary_cards/Element_SpiritGolem.png"),
	"stained glass": preload("res://assets/cards-assets/quartenary_cards/Element_Stained Glass.png"),
	"storm stone": preload("res://assets/cards-assets/quartenary_cards/Element_Stormstone.png"),
	"tears": preload("res://assets/cards-assets/quartenary_cards/Element_Tears.png"),
	"basalt dust": preload("res://assets/cards-assets/quartenary_cards/Element_BasaltDust.png"),
	"thunder": preload("res://assets/cards-assets/quartenary_cards/Element_Thunder.png"),
	"velarim": preload("res://assets/cards-assets/quartenary_cards/Element_Velarim.png"),
	"aureol": preload("res://assets/cards-assets/quartenary_cards/Element_Aureolo.png"),
	"silhain": preload("res://assets/cards-assets/quartenary_cards/Element_Silhain.png")
}

const FUSION_TABLE = {
	# Básico + Básico = Secundário
	["air", "earth"]: "sand",
	["earth", "air"]: "sand",

	["fire", "air"]: "lightning",
	["air", "fire"]: "lightning",

	["water", "air"]: "mist",
	["air", "water"]: "mist",

	["fire", "earth"]: "magma",
	["earth", "fire"]: "magma",

	["water", "earth"]: "clay",
	["earth", "water"]: "clay",

	["water", "fire"]: "steam",
	["fire", "water"]: "steam",

	# Básico + Secundário = Terciário
	["magma", "air"]: "glass",
	["magma", "water"]: "basalt",
	["magma", "earth"]: "obsidian",
	["magma", "fire"]: "ceramic",

	["lightning", "earth"]: "magnetite",
	["lightning", "water"]: "charged mist",
	["lightning", "fire"]: "stormstone",

	["sand", "water"]: "mud",
	["sand", "fire"]: "ash",
	["sand", "air"]: "stained glass",
	["sand", "earth"]: "frost",

	["mist", "earth"]: "swamp",
	["mist", "fire"]: "steam",
	["mist", "air"]: "cloud",
	["mist", "water"]: "fog",

	["clay", "fire"]: "brick",
	["clay", "air"]: "guardian",
	["clay", "earth"]: "idol",
	["clay", "water"]: "mill",

	["steam", "earth"]: "geyser",
	["steam", "air"]: "smoke",
	["steam", "fire"]: "furnace",
	["steam", "water"]: "mirror",

	# Secundário + Secundário = Terciário
	["glass", "lightning"]: "radiance",
	["magnetite", "mist"]: "engine",
	["magma", "mist"]: "halo",
	["clay", "lightning"]: "golem",
	["obsidian", "mist"]: "blade",
	["glass", "smoke"]: "dark mirror",
	["magma", "clay"]: "ceramic",
	["mist", "sand"]: "velarim",
	["steam", "sand"]: "silhain",

	# Terciário + Básico = Quaternário
	["radiance", "earth"]: "crystal",
	["radiance", "water"]: "prism",
	["radiance", "air"]: "halo",
	["radiance", "fire"]: "solar flame",
	["obsidian", "water"]: "shard",
	["obsidian", "air"]: "blade",
	["engine", "fire"]: "furnace",
	["engine", "water"]: "mill",
	["golem", "air"]: "spirit golem",
	["golem", "earth"]: "guardian",
	["frost", "fire"]: "tears",
	["basalt", "air"]: "basalt air",
	["charged mist","earth"]: "thunder",
	["geyser","air"]: "aureol"
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
		_reset_card(player_card, player_hand)
		_reset_card(npc_card, npc_hand)
		_reset_state()
		return

	var elements_pair = [player_card.element, npc_card.element]

	if not FUSION_TABLE.has(elements_pair):
		print("Fusão inválida para elementos: ", elements_pair)
		_reset_card(player_card, player_hand)
		_reset_card(npc_card, npc_hand)
		_reset_state()
		return

	var result_element = FUSION_TABLE[elements_pair]
	print("Fusão resultou em: ", result_element)

	# remover todas as cartas com os elementos usados
	_remove_cards_with_element(player_hand, player_card.element)
	_remove_cards_with_element(player_hand, npc_card.element)
	_remove_cards_with_element(npc_hand, player_card.element)
	_remove_cards_with_element(npc_hand, npc_card.element)

	# adicionar a carta resultante a ambas as mãos
	_add_card_to_hand(player_hand, result_element)
	_add_card_to_hand(npc_hand, result_element)

	_reset_state()

func _reset_state():
	GameState.played_card = false
	end_turn_button.visible = false
	end_turn_button.disabled = false
	merge_button.visible = false

func _reset_card(card: Node3D, hand: Node3D):
	card.global_position = hand.global_position
	card.reparent(hand)

func _add_card_to_hand(hand: Node3D, element: String):
	var card = card_base_scene.instantiate()
	card.element = element 

	var mesh = card.get_node("MeshInstance3D")
	var mat = mesh.get_active_material(0).duplicate()
	mesh.set_surface_override_material(0, mat)

	if mat and card_textures.has(element):
		mat.albedo_texture = card_textures[element]
	else:
		print("⚠️ Textura não encontrada para: ", element)

	hand.add_child(card)

	# calcular posição livre
	var positions = _get_player_start_positions() if hand == player_hand else _get_npc_start_positions()
	var used_positions: Array = []
	for child in hand.get_children():
		used_positions.append(child.global_position)

	var assigned = false
	for pos in positions:
		var occupied = false
		for used in used_positions:
			if pos.is_equal_approx(used):
				occupied = true
				break
		if not occupied:
			card.global_position = pos
			assigned = true
			break

	if not assigned:
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

func _remove_cards_with_element(hand: Node3D, element: String):
	for card in hand.get_children():
		if card.has_method("get") and card.get("element") == element:
			card.queue_free()
