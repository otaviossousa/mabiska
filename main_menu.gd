extends VBoxContainer

const MAIN = preload("res://main.tscn")

func _on_jogar_pressed() -> void:
	get_tree().change_scene_to_packed(MAIN)



func _on_sair_pressed() -> void:
	get_tree().quit()
