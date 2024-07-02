extends CharacterBody2D


@export var SPEED = 100.0
@export var ACCELERATION = 20.0
@export var FRICTION = 10.0
@onready var sprite = $Sprite
const KNIFE = preload("res://knife.tscn")
@onready var world = get_node('/root/World')
var direction = Vector2.ZERO

func _physics_process(delta):

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	direction = Input.get_vector("left","right","up","down").normalized()
	if direction:
		velocity = velocity.move_toward(direction * SPEED, ACCELERATION)
		
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION)
	
	if velocity.x > 0:
		sprite.flip_h = false  
	elif velocity.x < 0:
		sprite.flip_h = true

	move_and_slide()


func _on_knife_timer_timeout():
	var knife = KNIFE.instantiate()
	knife.global_position = global_position
	knife.look_at(get_global_mouse_position())
	#knife.rotate(direction.angle())
	add_sibling(knife)
