/datum/preference/numeric/cybergrid_alpha
	category = PREFERENCE_CATEGORY_GAME_PREFERENCES
	savefile_key = "cybergrid_alpha"
	savefile_identifier = PREFERENCE_PLAYER

	minimum = 0
	maximum = 255

/datum/preference/numeric/cybergrid_alpha/create_default_value()
	return 64

/datum/preference/numeric/cybergrid_alpha/apply_to_client(client/client, value)
	var/atom/movable/screen/fullscreen/cybergrid/cybergrid = locate() in client.screen
	if(!cybergrid)
		return

	cybergrid.alpha = value
