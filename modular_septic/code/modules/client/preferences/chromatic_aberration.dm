/// Whether or not to toggle chromatic aberration, the "3D effect"
/datum/preference/toggle/chromatic_aberration
	category = PREFERENCE_CATEGORY_GAME_PREFERENCES
	savefile_key = "chromaticaberration"
	savefile_identifier = PREFERENCE_PLAYER

/datum/preference/toggle/chromatic_aberration/apply_to_client(client/client, value)
	var/atom/movable/screen/plane_master/rendering_plate/game_world_pre_processing/plane_master = locate() in client?.screen
	if(!plane_master)
		return

	plane_master.backdrop(client.mob)
