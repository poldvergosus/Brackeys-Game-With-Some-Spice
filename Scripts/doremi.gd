extends Area2D
@onready var poldverg = $"../Poldverg"
@onready var animation_player = $AnimationPlayer


func _on_body_entered(body):
	if body.name in ["Poldverg", "poldverg"]:
		body.set_infinite_jump(true)
		animation_player.play("pickup")
   
