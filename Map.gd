extends Node2D

signal goal(body)
signal deal_damage(body, amount)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_Area2D_body_entered(body):
	emit_signal("goal",body)

func _on_DamageZone1_body_entered(body):
	emit_signal("deal_damage", body, 1)

func _on_DamageZone2_body_entered(body):
	emit_signal("deal_damage", body, 1)
