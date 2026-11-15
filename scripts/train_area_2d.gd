extends Area2D

func body_entered(body) -> void:
	if body.is_in_group("Passengers"):
		body.boarded()
