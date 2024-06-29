extends Node

@export var refs: AudioData
@onready var ui = $AudioManager/UI
@onready var player = $AudioManager/Player
@onready var music = $AudioManager/Music

var uiPlayer
var isMoving=false
var musicEQ
var musicGAIN

# Called when the node enters the scene tree for the first time.
func _ready():

	musicEQ=AudioServer.get_bus_effect(1,1)
	musicGAIN=AudioServer.get_bus_effect(1,0)
	#print(musicEQ.cutoff_hz)
	var stream=refs.Music[0]
	music.set_stream(stream)
	_fadeIn(music, 5.)
	await get_tree().create_timer(5.).timeout
	###################################

	#testTween.tween_property(musicEQ,"cutoff_hz",500.,5.) #NOT WORKING
	#musicEQ.set_cutoff(500.) #ORIGINAL CMD
	
	#testTween.tween_method(lowerMusic(),0.,-20,5.) #NOT WORKING
	
	#AudioServer.set_bus_volume_db(1,-80)  #ORIGINAL CMD
	
######################### VOLUME CONTROL ##############################

func _fadeIn(audioPlayer,time):

	audioPlayer.volume_db=-80.
	audioPlayer.play()
	var tween=get_tree().create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(audioPlayer,"volume_db",0., time)
	
func _fadeOut(audioPlayer,time):
	var tween=get_tree().create_tween()
	tween.set_ease(Tween.EASE_IN)
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(audioPlayer,"volume_db",-80., time)
	await get_tree().create_timer(time).timeout
	audioPlayer.stop()

func _crossFade(audioPlayer_1, audioPlayer_2, time):
	_fadeIn(audioPlayer_2, time)
	_fadeOut(audioPlayer_1, time)

######################### SNAPSHOTS ##############################

func _getHurtSnapshot():
	var hurtTween=get_tree().create_tween()

	#tween to lower the music bus volume in 0.25s
	hurtTween.set_ease(Tween.EASE_IN)
	hurtTween.set_trans(Tween.TRANS_QUAD)
	
	hurtTween.tween_property(musicEQ,"cutoff_hz",800.,0.0) #WORKS
	hurtTween.tween_interval(2)
	hurtTween.tween_property(musicEQ,"cutoff_hz",20000.,3.5) #WORKS
	#hurtTween.tween_property(musicGAIN,"volume_db",-20.,0.25) #WORKS
	#hurtTween.tween_property(musicGAIN,"volume_db",0.,1.) #WORKS

func _on_player_hurt():
	_getHurtSnapshot()

func lowerMusic():
	AudioServer.set_bus_volume_db(1, -20)

######################### MENU SFX ##############################

func _on_main_menu_start_game():
	ui.stream=refs.UI[0]
	ui.play()

func _on_play_button_mouse_entered():
	ui.stream=refs.UI[1]
	ui.pitch_scale=1.0
	ui.play()
func _on_quit_button_mouse_entered():
	ui.stream=refs.UI[1]
	ui.pitch_scale=0.6
	ui.play()

######################### PLAYER SFX ##############################
	
func _dragPlayerSFX():
	player.stream=refs.Player[0]
	_fadeIn(player,0.5)
	
func _stopDragPlayerSFX():
	_fadeOut(player,1.0)
	
######################### update ##############################

func _process(delta):
	if Input.is_action_just_pressed("jump") and !isMoving:
		_dragPlayerSFX()
		isMoving =true
	elif Input.is_action_just_pressed("jump") and isMoving:
		_stopDragPlayerSFX()
		isMoving =false



