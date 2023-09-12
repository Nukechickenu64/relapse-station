/obj/effect/decal/cleanable/can_bloodcrawl_in()
	if(blood_state in list(BLOOD_STATE_HUMAN, BLOOD_STATE_XENO))
		return bloodiness
	return 0
