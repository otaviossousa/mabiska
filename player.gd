extends Area3D

@onready var frog_sfx_1: AudioStreamPlayer = $frog_sfx_1
@onready var frog_sfx_2: AudioStreamPlayer = $frog_sfx_2

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
	
func _input_event(camera, event, event_position, normal, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			print("Clicou!")
			#aleatoriedade
			var play_num = randi_range(1,2)
			if play_num == 2:
				frog_sfx_1.play()
			else:
				frog_sfx_2.play(1.0)
			
