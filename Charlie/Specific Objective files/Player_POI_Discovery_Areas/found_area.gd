extends Area3D

#Objective level notes
# 0 equals just spawned in. This is where the intro and starting ambiance are built
#You start with the knife in your inventory/pick it up stright away.
# apon finding the sattelite, we reach objective 1
# now when interacting with the sattelite, we get 1.5, find the parts
# after finding and instering all ___ parts AND fixing the sattelite functions, move to objective 2
# Spawn in enemies, and start new communications up, now move to objective 2.1.
# Upon location of the weapons cache, get lots of ammo and the G32 + move to objective 2.5
# Now killing spree. Once all located enemies are dead, move to objective 3
# Locate the impact site, move to objective 3.5 as you kill random protecting enemies.
# Dungeon like gameplay 
# Finding the boss room sets game to objective 4.
#Killing the boss ends the game



#Most of this code works directly in tanden with the progress node,
#which stores all varibles for the HUD and other parts of the game to use!
func _on_body_entered(body):
	#Finding the sattelitte
	if Progress.current_objective == 0 and body.name == str("Wayne") and Progress.Sattelite_Discovered == false:
		Progress.current_objective = 1
		Progress.Sattelite_Discovered = true
	#Extra statement incase the player has already foud the parts to repair the sattelite
	if Progress.current_objective == 0.5 and body.name == str("Wayne") and Progress.Sattelite_Discovered == false:
		Progress.current_objective = 1.5
		Progress.Sattelite_Discovered = true
	#Finding the weapons cache
	if Progress.current_objective == 2.1 and body.is_in_group("player") and Progress.weapons_cache_found == false:
		Progress.weapons_cache_found == true
		Progress.current_objective = 2.5
	if Progress.current_objective == 3 and body.is_in_group("player") and Progress.impact_site_discovered == false:
		Progress.current_objective = 3.5
		Progress.impact_site_discovered = true
