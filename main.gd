extends Node3D

@onready var npc_hand = $npc_hand
@onready var end_turn_button := $CanvasLayer/EndTurnButton
@onready var merge_button = $CanvasLayer2/MergeButton

func _ready():
	end_turn_button.visible = false
	end_turn_button.connect("pressed", _on_end_turn_pressed)

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

	# Mostrar botão "Fundir"
	merge_button.visible = true

	end_turn_button.disabled = true
