# O QUE FAZER: ADICIONAR Nuvem de fala (label text com fundo) dando dicas...
# 1 . Precisamos de eletricidade para buscar a pedra filosofal, acredito que o ar seja uma boa carta...
# 2 . A luz se fez! Creio que trazê-la a Terra estaremos próximo da fusão perfeita
# 3 . A pedra filosofal está feita! Poderei te fazer príncipe outra vez

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
			
