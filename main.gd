extends Node3D

@onready var end_turn_button := $CanvasLayer/EndTurnButton

func _ready():
	end_turn_button.visible = false
	end_turn_button.connect("pressed", _on_end_turn_pressed)

func _process(delta):
	if GameState.played_card and not end_turn_button.visible:
		end_turn_button.visible = true

func _on_end_turn_pressed():
	print("Fim do turno do jogador.")
	#valores resetados
	end_turn_button.visible = false
	GameState.played_card = false
	GameState.selected_card = null
