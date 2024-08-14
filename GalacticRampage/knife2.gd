extends Area2D

@export var SPEED = 500

func _ready():
	pass



func _process(delta):
	translate(Vector2.RIGHT.rotated(rotation) * SPEED * delta)
