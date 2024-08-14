extends CharacterBody2D



const JUMP_VELOCITY = -400.0
@onready var sprite = $Sprite
@onready var player = get_tree().get_first_node_in_group("Player")
const EXPLOSION = preload("res://explosion.tscn")
const KNIFE_2 = preload("res://knife2.tscn")
@onready var world = get_node('/root/world')
var direction = Vector2.ZERO

func check_animation():
	if velocity == Vector2.ZERO:
		sprite.play("Idle")
	elif velocity.x != 0:
		sprite.play("Running")

	# Declare variables for the speed and the detection range
var SPEED = 50  # Adjust this to your desired speed
var DETECTION_RANGE = 150  # Adjust this to your desired detection range

func _physics_process(delta):
	# Calculate the direction to the player
	var direction_to_player = global_position.direction_to(player.global_position)
	
	# Calculate the distance to the player
	var distance_to_player = global_position.distance_to(player.global_position)
	
	# Move towards the player only if within the detection range
	if distance_to_player <= DETECTION_RANGE:
		velocity = direction_to_player * SPEED
	else:
		# If outside the detection range, set velocity to zero
		velocity = Vector2.ZERO



	# Apply the velocity to the enemy (assuming you're using a KinematicBody2D or similar)
	move_and_slide()
	check_animation()
	



	if velocity.x > 0: 
		sprite.flip_h = true 
	else:
		sprite.flip_h = false



func enemy_die(): 
	queue_free()
	var new_explosion = EXPLOSION.instantiate()
	new_explosion.global_position = global_position
	add_sibling(new_explosion)



func _on_knife_timer_timeout():
	var knife = KNIFE_2.instantiate()
	knife.global_position = global_position
	knife.rotate(direction.angle())           
	world.add_child(knife)
