extends Node
#Varible for the path to the enemy, plus a reference to where the sqawn node.  
@onready var enemy1 = preload("res://Charles Tracey - Project Manager/enemycultist/enemy.tscn")
@onready var enemy2 = preload("res://Charlie/Enemy_2/Enemy_2.tscn")
var spawn1
var spawn2
var spawn3
@onready var weapons_cache = preload("res://Charlie/Specific Objective files/Player_POI_Discovery_Areas/Weapons_Cache_Found.tscn")
var cache_spawn

#Begin with a reset objective
var current_objective = 0
# Objective 1 to 1.99 varibles
var Sattelite_Discovered = false
var Parts_Discovered = 0
#When this turns true, spawn enemies, then move to 2.1 so they dont spawn every frame.
var Sattelite_repaired = false

# Objective 2 to 2.99 varibles
var weapons_cache_found = false
var spawn_enemies_obj_2 = 12
var obj_2_enemies_killed = 0
var spawned = 0

#Objective 3 to 5 varibles
var impact_site_discovered = false
var boss_killed = false

var objective_1 = 0

#Objective level notes
# 0 equals just spawned in. This is where the intro and starting ambiance are built
#You start with the knife in your inventory/pick it up stright away.
# apon finding the sattelite, we reach objective 1
# now when interacting with the sattelite, we get 1.5, find the parts
# after finding and instering all ___ parts AND fixing the sattelite functions, move to objective 2
# Spawn in weapons cache, and start new communications up, now move to objective 2.1.
# Upon location of the weapons cache, get lots of ammo and the G32 + move + spawn in enemies to objective 2.5
# Now killing spree. Once all located enemies are dead, move to objective 3
# Locate the impact site, move to objective 3.5 as you kill random protecting enemies.
# Dungeon like gameplay 
# Finding the boss room sets game to objective 4.
#Killing the boss ends the game

func _process(_delta):
	#Cde that spawns in the qweapons cache and updates the objective once placed.
	if current_objective == 2:
		var instance = weapons_cache.instantiate()
		cache_spawn.add_child(instance)
		current_objective = 2.1
	#Special code that instantiate half the required enemies in two set spots (spawn 1 + 2)
	#at slightly different positions to ensure they dont stack or have some other glitch happen
	#due to overlapping collisions.
	if current_objective == 2.5:
		for i in spawn_enemies_obj_2 / 2:
			var instance2 = enemy1.instantiate()
			var instance3 = enemy1.instantiate()
			spawned = spawned + 2
			spawn_enemy(instance2, instance3)
	#Extra code added on incase I decide to change the amount of enemies that spawn in 
	#and I accidentally dont add enough to allow the game to progress to the next
	#objective when all are killed. (adds any extras required to meet "spawn_enemies_obj_2")
		if spawned < spawn_enemies_obj_2:
			for i in spawn_enemies_obj_2 - spawned:
				var instance2 = enemy1.instantiate()
				instance2.position.x = randf() * 4
				instance2.position.z = randf() * 4
				spawn1.add_child(instance2)
		current_objective = 2.55
	#Progresses once all are killed
	if obj_2_enemies_killed >= spawn_enemies_obj_2 and current_objective == 2.6:
		current_objective = 3
		
	#Player death.
	if Global.health <= 0:
		get_tree().change_scene_to_file("res://Charlie/UI/credits.tscn")
		#print("You reached objective ", current_objective)
		
func spawn_enemy(instance2, instance3):
	instance2.position.x = randf() * 4
	instance2.position.z = randf() * 4
	instance3.position.x = randf() * 4
	instance3.position.z = randf() * 4
	spawn1.add_child(instance2)
	spawn2.add_child(instance3)
