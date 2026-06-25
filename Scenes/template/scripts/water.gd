extends Area2D

@export var boyuncy : float
@export var max_boyuncy : float
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var bodies = self.get_overlapping_bodies()
	for body : CharacterBody2D in bodies:
		body.velocity.y -= boyuncy * delta
		body.velocity.y = max(-max_boyuncy,body.velocity.y)
		if body.is_in_group("enemy"):
			body.queue_free()
	pass
