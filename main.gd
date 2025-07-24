extends Node3D

@onready var player_hand := $player_hand
@onready var npc_hand = $npc_hand
@onready var end_turn_button := $CanvasLayer/EndTurnButton
@onready var merge_button = $CanvasLayer2/MergeButton

#Import basic elements_cards
var player_deck_elements = ["fire", "water", "earth", "air"]
var npc_deck_elements = ["fire", "water", "earth", "air"]

#import cards scenes
@onready var card_base_scene := preload("res://deck scenes/card_base.tscn")

const CardTextures = preload("res://data/texture_cards.gd")
const FusionTable = preload("res://data/fusion_cards.gd")

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

	# Embaralhar as cartas do NPC
	npc_cards.shuffle()

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

	var result_element = FusionTable.get_fusion_result(player_card.element, npc_card.element)

	if result_element == "":
		print("Fusão inválida para elementos: ", player_card.element, " + ", npc_card.element)
		_reset_card(player_card, player_hand)
		_reset_card(npc_card, npc_hand)
		_reset_state()
		return

	print("Fusão resultou em: ", result_element)
	
	# Verificar progressão da fusão especial
	var a = player_card.element
	var b = npc_card.element

	# Ordenar os elementos para fusões não dependerem da ordem
	var sorted = [a, b]
	sorted.sort()

# Etapas da busca pela "philo"
	if sorted == ["air", "fire"] and result_element == "lightning":
		print("Parabéns! Está no rumo certo... a luz surgiu!")
	elif sorted == ["earth", "lightning"] and result_element == "magnetite":
		print("Muito bem! Você criou a magnetita! Mais uma fusão e chegará ao final")
	elif sorted == ["magnetite", "water"] and result_element == "philo":
		print("Parabéns! Você venceu! Criou a lendária Pedra Filosofal!")


	# remover todas as cartas com os elementos usados
	_remove_cards_with_element(player_hand, player_card.element)
	_remove_cards_with_element(player_hand, npc_card.element)
	_remove_cards_with_element(npc_hand, player_card.element)
	_remove_cards_with_element(npc_hand, npc_card.element)

	# adicionar a carta resultante a ambas as mãos
	_add_card_to_hand(player_hand, result_element)
	_add_card_to_hand(npc_hand, result_element)

	_reset_state()
	call_deferred("_check_end_game_condition")

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

	var texture = CardTextures.get_texture(element)
	if mat and texture:
		mat.albedo_texture = texture
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

		var texture = CardTextures.get_texture(element)
		if mat and texture:
			mat.albedo_texture = texture
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


func _on_reset_button_pressed() -> void:
	reset_game()
	
func reset_game():
	# Limpa mãos
	for card in player_hand.get_children():
		card.queue_free()
	for card in npc_hand.get_children():
		card.queue_free()

	# Recria mãos com as cartas iniciais
	_initialize_hand(player_hand, player_deck_elements, _get_player_start_positions())
	_initialize_hand(npc_hand, npc_deck_elements, _get_npc_start_positions())

	# Reset estados globais
	GameState.played_card = false
	GameState.selected_card = null
	GameState.player_played_card = null
	GameState.player_card_type = ""

	# Esconde o botão
	$CanvasReset/ResetButton.visible = false

func _check_end_game_condition():
	print("Player hand count: ", player_hand.get_child_count())
	print("NPC hand count: ", npc_hand.get_child_count())
	if player_hand.get_child_count() == 3 and npc_hand.get_child_count() == 3:
		print("Fim de jogo! Só resta uma carta para cada lado.")
		$CanvasReset/ResetButton.visible = true
