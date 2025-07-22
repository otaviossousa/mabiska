extends Control

@onready var color_rect = $ColorRect
@onready var texture_rect = $VBoxContainer/TextureRect
@onready var label = $VBoxContainer/Label
@onready var close_button = $Button

func _ready():
	visible = false
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	close_button.pressed.connect(_on_close_pressed)

func show_card(texture: Texture2D, description: String):
	texture_rect.texture = texture
	label.text = description
	mouse_filter = Control.MOUSE_FILTER_STOP
	visible = true

func _on_close_pressed():
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	visible = false
