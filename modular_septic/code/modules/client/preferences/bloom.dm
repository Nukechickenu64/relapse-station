/// Whether or not to toggle bloom
/datum/preference/toggle/bloom
	category = PREFERENCE_CATEGORY_GAME_PREFERENCES
	savefile_key = "bloom"
	savefile_identifier = PREFERENCE_PLAYER

/datum/preference/toggle/bloom/apply_to_client(client/client, value)
	var/atom/movable/screen/plane_master/floor_bloom/floor_bloom = locate() in client.screen
	floor_bloom?.backdrop(client.mob)
	var/atom/movable/screen/plane_master/game_world_bloom/game_bloom = locate() in client.screen
	game_bloom?.backdrop(client.mob)
