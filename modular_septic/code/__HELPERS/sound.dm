/proc/setup_audio_tracks()
	. = list()
	for(var/datum/audio/track as anything in init_subtypes(/datum/audio))
		if(track.file)
			.[track.type] = track
		else
			qdel(track)
