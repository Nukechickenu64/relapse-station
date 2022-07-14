/// Whether or not to toggle bloom
/datum/preference/toggle/bloom
	category = PREFERENCE_CATEGORY_GAME_PREFERENCES
	savefile_key = "bloom"
	savefile_identifier = PREFERENCE_PLAYER

/datum/preference/toggle/bloom/apply_to_client(client/client, value)
	var/atom/movable/screen/plane_master/game_world_bloom/plane_master = locate() in client?.screen
	if(!plane_master)
		return

	plane_master.backdrop(client.mob)
