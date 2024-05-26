extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	TitleScreenMusic._play_music_title()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
	


func _on_quit_pressed():
	get_tree().quit()


func _on_options_pressed():
	get_tree().change_scene_to_file("res://Options.tscn")


func _on_start_pressed():
	get_tree().change_scene_to_file("res://CharacterChoice.tscn")
