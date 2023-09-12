/proc/parse_zone(zone)
	switch(zone)
		if(BODY_ZONE_PRECISE_L_EYE)
			return "left eyesocket"
		if(BODY_ZONE_PRECISE_R_EYE)
			return "right eyesocket"
		if(BODY_ZONE_PRECISE_MOUTH)
			return "jaw"
		if(BODY_ZONE_PRECISE_NECK)
			return "throat"
		if(BODY_ZONE_PRECISE_R_HAND)
			return "right hand"
		if(BODY_ZONE_PRECISE_R_FINGER_THUMB)
			return "right thumb"
		if(BODY_ZONE_PRECISE_R_FINGER_INDEX)
			return "right index finger"
		if(BODY_ZONE_PRECISE_R_FINGER_MIDDLE)
			return "right middle finger"
		if(BODY_ZONE_PRECISE_R_FINGER_RING)
			return "right ring finger"
		if(BODY_ZONE_PRECISE_R_FINGER_PINKY)
			return "right pinky finger"
		if(BODY_ZONE_PRECISE_L_HAND)
			return "left hand"
		if(BODY_ZONE_PRECISE_L_FINGER_THUMB)
			return "left thumb"
		if(BODY_ZONE_PRECISE_L_FINGER_INDEX)
			return "left index finger"
		if(BODY_ZONE_PRECISE_L_FINGER_MIDDLE)
			return "left middle finger"
		if(BODY_ZONE_PRECISE_L_FINGER_RING)
			return "left ring finger"
		if(BODY_ZONE_PRECISE_L_FINGER_PINKY)
			return "left pinky finger"
		if(BODY_ZONE_L_ARM)
			return "left arm"
		if(BODY_ZONE_R_ARM)
			return "right arm"
		if(BODY_ZONE_L_LEG)
			return "left leg"
		if(BODY_ZONE_R_LEG)
			return "right leg"
		if(BODY_ZONE_PRECISE_L_FOOT)
			return "left foot"
		if(BODY_ZONE_PRECISE_R_FOOT)
			return "right foot"
		else
			return zone
