extends Area2D
@onready var poldverg = $"../Poldverg"


func _on_body_entered(body):
	if body.name in ["Poldverg", "poldverg"]:
		body.set_infinite_jump(true)
		queue_free()
   
