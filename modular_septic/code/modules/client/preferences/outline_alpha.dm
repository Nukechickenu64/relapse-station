/datum/preference/numeric/outline_alpha
	category = PREFERENCE_CATEGORY_GAME_PREFERENCES
	savefile_key = "outline_alpha"
	savefile_identifier = PREFERENCE_PLAYER

	minimum = 0
	maximum = 255

/datum/preference/numeric/outline_alpha/create_default_value()
	return 64

/datum/preference/numeric/outline_alpha/apply_to_client(client/client, value)
	var/atom/movable/screen/plane_master/outline/plane_master = locate() in client?.screen
	if(!plane_master)
		return

	plane_master.backdrop(client.mob)
