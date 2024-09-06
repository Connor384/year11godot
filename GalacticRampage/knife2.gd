extends Area2D



@onready var sprite = $Sprite
@onready var player = get_tree().get_first_node_in_group("Player")
@export var SPEED = 1000 



func _ready():
	pass



func _process(delta):
	translate(Vector2.RIGHT.rotated(rotation) * SPEED * delta)



func _on_body_entered(body: Node2D) -> void:
	queue_free()
