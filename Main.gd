extends Node

var counter = 0.0
export (PackedScene) var player


func _ready():
	var pencil = $CanvasLayer/HUD/MarginContainer/VBoxContainer/MarginContainer/PlayerStatus/Pencil
	var hp = $CanvasLayer/HUD/MarginContainer/VBoxContainer/MarginContainer/PlayerStatus/Health


func _process(delta):
	$Camera2D.position = $Player.position
