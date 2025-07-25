extends Area3D

var highlight_material: Material
var mesh: MeshInstance3D

func _ready():
	mesh = $player
	connect("mouse_entered", _on_mouse_entered)
	connect("mouse_exited", _on_mouse_exited)

func _on_mouse_entered():
	print("Mouse sobre o player")
	
func _on_mouse_exited():
	print("Mouse saiu do player")
