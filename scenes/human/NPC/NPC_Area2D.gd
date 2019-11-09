extends "res://scenes/human/human_Area2D.gd"




func init(spd,rot,hlth,dmg,destination):
	linear_speed = spd
	rotation_speed = rot
	max_health = hlth
	damage = dmg
	leader = destination
	following_unit = true
	
	
func control(delta):
	if following_player:
		follow_player(delta)
	if following_unit:
		follow_unit(delta)
		

	
	

	

func follow_player(delta):
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


func follow_unit(delta):
	var MAX_SPEED = linear_speed
	var follower_destination = (leader.get_global_position() - position)
	var follower_destination_norm = follower_destination.normalized()
	#set follower rotation
	rotation = Vector2(1,0).rotated(rotation).linear_interpolate(follower_destination_norm,rotation_speed*delta).angle()
	
	var follower_desired_velocity = follower_destination
	var follower_distance = follower_desired_velocity.length()
	var slowingRadius = 50
	if follower_distance < slowingRadius:
		follower_desired_velocity = follower_desired_velocity.normalized() * MAX_SPEED * (follower_distance / slowingRadius)
	else:
		follower_desired_velocity = follower_desired_velocity.normalized() * MAX_SPEED
	var MAX_STEER = 13
	var follower_steering = follower_desired_velocity - velocity
	#print(follower_steering)
	follower_steering = follower_steering.clamped(MAX_STEER)
	var follower_mass = 1
	follower_steering = follower_steering / follower_mass 	#mass
	if follower_distance < 40:
		rotation = Vector2(1,0).rotated(rotation).linear_interpolate(Vector2(1,0).rotated(leader.get_parent().get_parent().get_parent().get_parent().rotation),6*delta).angle()
	#print(leader)
	velocity = (velocity + follower_steering).clamped(MAX_SPEED)
	if velocity.length() < 5:
		movement_completed = true
		movement_started = false
	#print(velocity)
	#print(follower_distance)
		
	
	


	