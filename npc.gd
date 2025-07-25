extends Area3D

var mesh: MeshInstance3D

func _ready():
	mesh = $player
	connect("mouse_entered", _on_mouse_entered)
	connect("mouse_exited", _on_mouse_exited)

func _on_mouse_entered():
	print("Mouse sobre o npc")
	
func _on_mouse_exited():
	print("Mouse saiu do npc")
	
func _input_event(camera, event, event_position, normal, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			print("Clicou!")
			
