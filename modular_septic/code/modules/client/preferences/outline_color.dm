/// The color of your runechat and say CSS
/datum/preference/color/outline_color
	category = PREFERENCE_CATEGORY_GAME_PREFERENCES
	savefile_key = "outline_color"
	savefile_identifier = PREFERENCE_PLAYER

/datum/preference/color/outline_color/create_default_value()
	return "#97edca"

/datum/preference/color/outline_color/apply_to_client(client/client, value, datum/preferences/preferences)
	var/atom/movable/screen/plane_master/outline/plane_master = locate() in client.screen
	if(!plane_master)
		return

	plane_master.backdrop(client.mob)
