extends Area3D

@export var element: String = "air"
var owner_type: String = ""

func _ready():
	if get_parent().name == "player_hand":
		owner_type = "player"
	else:
		owner_type = "npc"
	connect("mouse_entered", _on_mouse_entered)
	connect("mouse_exited", _on_mouse_exited)

func _on_mouse_entered():
	if owner_type != "player":
		return
	print("Hover sobre carta: ", element)

func _on_mouse_exited():
	if owner_type != "player":
		return
	print("Saiu de cima da carta: ", element)
