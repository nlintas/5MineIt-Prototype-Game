extends MarginContainer

# * Attributes *
var title_scene = load("res://TitleScreen/TitleScreen.tscn")

onready var music_selector = $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer/HBoxContainer/Selector
onready var back_selector = $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer2/HBoxContainer/Selector
var current_selection = 0

# Audio
var audioPlayer = AudioStreamPlayer.new()
var buttonAudioPlayer = AudioStreamPlayer.new()

# * System Callback Methods *
func _ready():
	set_current_selector(0)
	# Audio Mute Music
	if(!GlobalVariables.enable_music):
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), true)
	set_current_selector(0)
	self.add_child(audioPlayer)
	self.add_child(buttonAudioPlayer)
	# Background Music
	audioPlayer.stream = load ('res://Music and Sounds/Background Music/02 Space Riddle.ogg')
	audioPlayer.play()
	
func _process(_delta):
	if Input.is_action_just_pressed("down") and current_selection < 1:
		# Button Sound Effect
		buttonAudioPlayer.stream = load ('res://Music and Sounds/Menu Sound Effects/navigating_selector.ogg')
		buttonAudioPlayer.play()
		
		current_selection += 1
		set_current_selector(current_selection)
		
	elif Input.is_action_just_pressed("up") and current_selection > 0:
		# Button Sound Effect
		buttonAudioPlayer.stream = load ('res://Music and Sounds/Menu Sound Effects/navigating_selector.ogg')
		buttonAudioPlayer.play()
		
		current_selection -= 1
		set_current_selector(current_selection)
		
	elif Input.is_action_just_pressed("ui_accept"):
		# Button Sound Effect
		buttonAudioPlayer.stream = load ('res://Music and Sounds/Menu Sound Effects/confirm_selection.ogg')
		buttonAudioPlayer.play()
		
		handle_selection(current_selection)

# * Methods *
func set_current_selector(_current_selection):
	music_selector.text=""
	back_selector.text=""
	
	if _current_selection == 0:
		music_selector.text=">"
	elif _current_selection == 1:
		back_selector.text =">"
		
func handle_selection(_current_selection):
	
	if _current_selection == 0:
		pass
	elif _current_selection == 1:
		get_parent().add_child(title_scene.instance())
		queue_free()

func _on_BackButton_pressed():
	# Button Sound Effect
	buttonAudioPlayer.stream = load ('res://Music and Sounds/Menu Sound Effects/confirm_selection.ogg')
	buttonAudioPlayer.play()
	
	current_selection = 1
	switchScenes()
	
func switchScenes():
	set_current_selector(current_selection)
	handle_selection(current_selection)

func _on_CheckBox_toggled(button_pressed):
	GlobalVariables.enable_music = button_pressed
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), button_pressed)
