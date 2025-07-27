# O QUE FAZER: ADICIONAR Nuvem de fala (label text com fundo) dando dicas...
# 1 . Precisamos de eletricidade para buscar a pedra filosofal, acredito que o ar seja uma boa carta...
# 2 . A luz se fez! Creio que trazê-la a Terra estaremos próximo da fusão perfeita
# 3 . A pedra filosofal está feita! Poderei te fazer príncipe outra vez

extends Area3D

@onready var balloon_label: Control = get_node("/root/main/CanvasNpc/BalloonLabel")
@onready var balloon_text: Label = balloon_label.get_node("Label")

var last_fusion_step := 0

func _ready():
	connect("mouse_entered", _on_mouse_entered)
	connect("mouse_exited", _on_mouse_exited)

func _on_mouse_entered():
	print("Mouse sobre o npc")
	_show_balloon()
	
func _on_mouse_exited():
	print("Mouse saiu do npc")
	_hide_balloon()
	
func _input_event(_camera, event, _event_position, _normal, _shape_idx):
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			print("Clicou!")

func _show_balloon():
	var msg := ""
	match last_fusion_step:
		0:
			msg = "Meu príncipe amado! Você virou um sapo!\nPara reverter esse maldoso feitiço\nprecisaremos encontrar a pedra filosofal\nao fundir essas cartas mágicas!\n\nPrecisamos de eletricidade...\nAcredito que o ar seja uma boa carta."
		1:
			msg = "A luz se fez!\nCreio que ao trazê-la a Terra\nestaremos próximo da fusão perfeita"
		2: 
			msg = "Muito bem! Você criou a magnetita!\nMais uma fusão e chegará ao final"
		3:
			msg = "A pedra filosofal está feita!\nPoderei te fazer príncipe outra vez."
		7:
			msg = "Hmm... tente combinar as cartas mágicas.\n se não der certo podemos reiniciar...\n\nPodemos tirar muitos resultados, mas\n nosso foco é termos a Pedra Filosofal"
		_:
			msg = "Hmm... tente combinar as cartas mágicas.\n se não der certo podemos reiniciar..."

	balloon_text.text = msg
	balloon_label.visible = true

func _hide_balloon():
	balloon_label.visible = false
