extends CharacterBody2D



@export var SPEED = 100
@export var ACCELERATION = 20.0
@export var FRICTION = 20.0
@onready var sprite = $Sprite
const KNIFE = preload("res://knife.tscn")
@onready var world = get_node('/root/World')
const BULLET = preload("res://bullet.tscn")
var direction = Vector2.ZERO



func check_animation():
	if velocity == Vector2.ZERO:
		sprite.play("Idle")
	elif velocity.x != 0:
		sprite.play("Running")



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



	check_animation()
	move_and_slide()



# Declare a variable to track the time since the last shot
var time_since_last_shot = 0.0
# Set the cooldown time between shots (in seconds)
var shoot_cooldown = 0.2  # Example: 0.2 seconds cooldown

func _process(delta):
	# Update the time since the last shot
	time_since_last_shot += delta

	# Check if the shoot key is pressed and enough time has passed since the last shot
	if Input.is_action_pressed("shoot") and time_since_last_shot >= shoot_cooldown:
		shoot()
		# Reset the time since the last shot
		time_since_last_shot = 0.0



func shoot():
	var new_bullet = BULLET.instantiate()
	new_bullet.global_position = global_position
	new_bullet.look_at(get_global_mouse_position())
	add_sibling(new_bullet)
