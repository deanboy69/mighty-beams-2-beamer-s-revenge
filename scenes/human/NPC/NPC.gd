extends "res://scenes/human/human.gd"


var following_unit = false
var following_player = false

var leader = null


func init(spd,rot,hlth,dmg,leader):
	linear_speed = spd
	rotation_speed = rot
	max_health = hlth
	damage = dmg
	set_role('following_player',leader)
	
	
func control(delta):
	if leader != null:
		follow_leader(delta)

	
	

	

func follow_leader(delta):
	
	var MAX_SPEED = leader.linear_speed
	var leader_transform = leader.velocity * -1
	var LEADER_BEHIND_DIST = 50
	leader_transform = leader_transform.normalized() * LEADER_BEHIND_DIST
	var follower_destination = (leader.position - position) + leader_transform
	var follower_destination_norm = follower_destination.normalized()
	#set follower rotation
	rotation = Vector2(1,0).rotated(rotation).linear_interpolate(follower_destination_norm,rotation_speed*delta).angle()
	
	var follower_desired_velocity = follower_destination
	var follower_distance = follower_desired_velocity.length()
	var slowingRadius = 100
	if follower_distance < slowingRadius:
		follower_desired_velocity = follower_desired_velocity.normalized() * MAX_SPEED * (follower_distance / slowingRadius)
	else:
		follower_desired_velocity = follower_desired_velocity.normalized() * MAX_SPEED
	var MAX_STEER = 7
	var follower_steering = follower_desired_velocity - velocity
	#print(follower_steering)
	follower_steering = follower_steering.clamped(MAX_STEER)
	var follower_mass = 1
	follower_steering = follower_steering / follower_mass 	#mass
	velocity = (velocity + follower_steering).clamped(MAX_SPEED)
	print(follower_distance)

		
	
	
func set_role(role,destination):
	if role == 'following_player':
		following_player = true
		following_unit = false
		leader = destination
	if role == 'in_unit':
		following_player = false
		following_unit = true
	


