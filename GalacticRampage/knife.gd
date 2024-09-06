extends Area2D



@export var SPEED = 1000
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	translate(transform.x * SPEED * delta)



func _on_body_entered(body):
	queue_free()



	if body.is_in_group("Enemy") and body.has_method("take_damage"):
		body.take_damage(WeaponKnife.knife_damage)
