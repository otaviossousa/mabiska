extends Control

@onready var color_rect = $ColorRect
@onready var texture_rect = $VBoxContainer/TextureRect
@onready var label = $ColorRect/Label
@onready var close_button = $Button

const CardDescriptions = preload("res://data/card_descriptions.gd")

func _ready():
	visible = false
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	close_button.pressed.connect(_on_close_pressed)
	
	# Configurar o label para melhor formatação de texto
	if label:
		label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
		label.vertical_alignment = VERTICAL_ALIGNMENT_TOP
		label.horizontal_alignment = HORIZONTAL_ALIGNMENT_LEFT
		
		# Adicionar margens internas para melhor legibilidade
		if label is RichTextLabel:
			var rich_label = label as RichTextLabel
			rich_label.bbcode_enabled = true
			rich_label.fit_content = true
			rich_label.scroll_active = false
		else:
			# Para Label comum, configurar alinhamento
			label.clip_contents = true

func show_card(texture: Texture2D, element: String):
	var card_info = CardDescriptions.get_card_info(element)
	
	texture_rect.texture = texture
	
	# Formatação otimizada para o espaço disponível
	var formatted_text = ""
	
	if label is RichTextLabel:
		# Formato rico com BBCode otimizado para espaço
		formatted_text += "[center][font_size=18][color=#FFD700][b]" + card_info["name"] + "[/b][/color][/font_size][/center]
"
		formatted_text += "[center][font_size=12][color=#CCCCCC][i]" + card_info["type"] + "[/i][/color][/font_size][/center]
"
		formatted_text += "[font_size=14][color=#87CEEB][b]Descrição:[/b][/color][/font_size]
"
		formatted_text += "[font_size=12]" + card_info["description"] + "[/font_size]

"
		formatted_text += "[font_size=14][color=#DDA0DD][b]História:[/b][/color][/font_size]
"
		formatted_text += "[font_size=12][i]" + card_info["lore"] + "[/i][/font_size]"
	else:

		formatted_text += card_info["name"].to_upper() + ":\n" + card_info["type"] + "\n\n"
		
		formatted_text += "DESCRIÇÃO:\n" + card_info["description"] + "\n\n"
		
		formatted_text += "HISTÓRIA:\n" + card_info["lore"]
	
	label.text = formatted_text
	mouse_filter = Control.MOUSE_FILTER_STOP
	visible = true

func _on_close_pressed():
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	visible = false
