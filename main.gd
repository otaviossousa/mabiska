extends Node3D

@onready var player_hand := $player_hand
@onready var npc_hand = $npc_hand
@onready var end_turn_button := $CanvasLayer/EndTurnButton
@onready var merge_button = $CanvasLayer2/MergeButton

#import secondary cards
@onready var card_electricity_scene := preload("res://deck scenes/card_electricity.tscn")

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

	# Secondary
	["lightning", "earth"]: "magnetite",
	["lightning", "water"]: "charged mist",
	["magma", "air"]: "glass",
	["magma", "water"]: "basalt",
	["vapor", "earth"]: "geyser",
	["vapor", "air"]: "smoke",
	["sand", "fire"]: "ash",
	["sand", "water"]: "mud",
	["clay", "fire"]: "brick",
	["clay", "air"]: "dust",
	["mist", "earth"]: "swamp",
	["mist", "fire"]: "steam",

	# Terciary
	["glass", "lightning"]: "radiance",
	["magnetite", "vapor"]: "engine",
	["clay", "lightning"]: "animated golem",
	["mist", "dust"]: "frosted glass",
	["magma", "clay"]: "obsidian",

	# Sec + sec = quaternary
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
	end_turn_button.visible = false
	end_turn_button.connect("pressed", _on_end_turn_pressed)
	
	merge_button.visible = false
	merge_button.connect("pressed", _on_merge_pressed)


func _process(delta):
	if GameState.played_card and not end_turn_button.visible:
		end_turn_button.visible = true

func _on_end_turn_pressed():
	print("Jogador finalizou turno!")

	# Escolher carta aleatória do NPC
	var npc_cards = npc_hand.get_children()
	if npc_cards.is_empty():
		print("NPC não tem cartas")
		return

	var npc_card = npc_cards[randi() % npc_cards.size()]
	npc_card.global_position = Vector3(-0.100, 0.559, 0.579)
	GameState.npc_played_card = npc_card


	# Mostrar botão "Fundir"
	merge_button.visible = true

	end_turn_button.disabled = true

func _on_merge_pressed():
	print("Fusão iniciada!")

	# encontrar as cartas na mesa
	var player_card = GameState.player_played_card
	var npc_card = GameState.npc_played_card

	if not player_card or not npc_card:
		print("Cartas para fusão não encontradas")
		player_card.queue_free()
		npc_card.queue_free()
		return

	var elements_pair = [player_card.element, npc_card.element]

	if not FUSION_TABLE.has(elements_pair):
		print("Fusão inválida para elementos: ", elements_pair)
		return

	var result_element = FUSION_TABLE[elements_pair]
	print("Fusão resultou em: ", result_element)

	# devolver as cartas para os decks --> Trocar para ELIMINAR
	#player_card.global_position = Vector3(0.515, 0.559, 0.064) # ajuste para posição do deck
	#npc_card.global_position = Vector3(-0.628, 0.559, 0.051) # ajuste para posição do deck NPC
	#player_card.reparent(player_hand)
	#npc_card.reparent(npc_hand)
	player_card.queue_free()
	npc_card.queue_free()

	# instanciar nova carta e adicionar a ambos decks
	var new_card_player = card_electricity_scene.instantiate()
	var new_card_npc = card_electricity_scene.instantiate()

	player_hand.add_child(new_card_player)
	npc_hand.add_child(new_card_npc)

	# resetar estado
	GameState.played_card = false
	end_turn_button.visible = false
	end_turn_button.disabled = false
	merge_button.visible = false
