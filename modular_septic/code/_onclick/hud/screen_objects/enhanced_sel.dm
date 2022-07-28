/atom/movable/screen/enhanced_sel
	name = "enhanced zone"
	icon = 'modular_septic/icons/hud/quake/screen_quake_enhance.dmi'
	icon_state = "enhanced"
	base_icon_state = "enhanced"
	screen_loc = ui_enhancesel
	screentip_flags = SCREENTIP_HOVERER_CLICKER
	var/overlay_icon = 'modular_septic/icons/hud/quake/screen_quake_enhance.dmi'
	var/static/list/hover_overlays_cache = list()
	var/hovering

/obj/effect/overlay/enhanced_sel
	icon = 'modular_septic/icons/hud/quake/screen_quake_enhance.dmi'
	plane = ABOVE_HUD_PLANE
	alpha = 128
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	anchored = TRUE
/atom/movable/screen/enhanced_sel/Initialize(mapload)
	. = ..()
	LAZYINITLIST(hover_overlays_cache[overlay_icon])

/atom/movable/screen/enhanced_sel/update_icon_state()
	. = ..()
	if(!hud?.mymob)
		icon_state = base_icon_state
		return
	switch(hud.mymob.zone_selected)
		if(BODY_ZONE_HEAD, BODY_ZONE_PRECISE_R_EYE, BODY_ZONE_PRECISE_L_EYE, BODY_ZONE_PRECISE_FACE, BODY_ZONE_PRECISE_MOUTH, BODY_ZONE_PRECISE_NECK)
			icon_state = "[base_icon_state]_head"
		if(BODY_ZONE_PRECISE_R_HAND, BODY_ZONE_PRECISE_R_FINGER_THUMB, BODY_ZONE_PRECISE_R_FINGER_INDEX, BODY_ZONE_PRECISE_R_FINGER_MIDDLE, BODY_ZONE_PRECISE_R_FINGER_RING, BODY_ZONE_PRECISE_R_FINGER_PINKY)
			icon_state = "[base_icon_state]_hand_r"
		if(BODY_ZONE_PRECISE_L_HAND, BODY_ZONE_PRECISE_L_FINGER_THUMB, BODY_ZONE_PRECISE_L_FINGER_INDEX, BODY_ZONE_PRECISE_L_FINGER_MIDDLE, BODY_ZONE_PRECISE_L_FINGER_RING, BODY_ZONE_PRECISE_L_FINGER_PINKY)
			icon_state = "[base_icon_state]_hand_l"
		if(BODY_ZONE_PRECISE_R_FOOT, BODY_ZONE_PRECISE_R_TOE_BIG, BODY_ZONE_PRECISE_R_TOE_LONG, BODY_ZONE_PRECISE_R_TOE_MIDDLE, BODY_ZONE_PRECISE_R_TOE_RING, BODY_ZONE_PRECISE_R_TOE_PINKY)
			icon_state = "[base_icon_state]_foot_r"
		if(BODY_ZONE_PRECISE_L_FOOT, BODY_ZONE_PRECISE_L_TOE_BIG, BODY_ZONE_PRECISE_L_TOE_LONG, BODY_ZONE_PRECISE_L_TOE_MIDDLE, BODY_ZONE_PRECISE_L_TOE_RING, BODY_ZONE_PRECISE_L_TOE_PINKY)
			icon_state = "[base_icon_state]_foot_l"

/atom/movable/screen/enhanced_sel/update_overlays()
	. = ..()
	if(!(hud?.mymob?.zone_selected in ENHANCEABLE_BODYZONES))
		return
	. += mutable_appearance(overlay_icon, "[hud.mymob.zone_selected]")

/atom/movable/screen/enhanced_sel/Click(location, control,params)
	. = ..()
	if(isobserver(usr))
		return

	var/list/modifiers = params2list(params)
	var/icon_x = text2num(LAZYACCESS(modifiers, ICON_X))
	var/icon_y = text2num(LAZYACCESS(modifiers, ICON_Y))
	var/choice = get_zone_at(icon_x, icon_y)
	if (!choice)
		return 1

	return set_selected_zone(choice, usr)

/atom/movable/screen/enhanced_sel/return_screentip(mob/user, params)
	if(flags_1 & NO_SCREENTIPS_1)
		return ""

	var/list/modifiers = params2list(params)
	var/icon_x = text2num(LAZYACCESS(modifiers, ICON_X))
	var/icon_y = text2num(LAZYACCESS(modifiers, ICON_Y))
	var/parsed_zone = get_zone_at(icon_x, icon_y)
	if(!parsed_zone)
		return SCREENTIP_OBJ(uppertext(name))
	parsed_zone = parse_zone(parsed_zone)
	return SCREENTIP_OBJ(uppertext(parsed_zone))

/atom/movable/screen/enhanced_sel/MouseEntered(location, control, params)
	. = ..()
	MouseMove(location, control, params)

/atom/movable/screen/enhanced_sel/MouseMove(location, control, params)
	. = ..()
	if(isobserver(usr))
		return

	var/list/modifiers = params2list(params)
	var/icon_x = text2num(LAZYACCESS(modifiers, ICON_X))
	var/icon_y = text2num(LAZYACCESS(modifiers, ICON_Y))
	var/choice = get_zone_at(icon_x, icon_y)
	if(!choice)
		vis_contents -= hover_overlays_cache[overlay_icon][hovering]
		hovering = null
		return
	if(hovering == choice)
		return

	vis_contents -= hover_overlays_cache[overlay_icon][hovering]
	hovering = choice

	var/obj/effect/overlay/enhanced_sel/overlay_object = hover_overlays_cache[overlay_icon][choice]
	if(!overlay_object)
		overlay_object = new
		overlay_object.icon = overlay_icon
		overlay_object.icon_state = "[choice]"
		hover_overlays_cache[overlay_icon][choice] = overlay_object
	vis_contents += overlay_object

/atom/movable/screen/enhanced_sel/MouseExited(location, control, params)
	. = ..()
	if(!isobserver(usr) && hovering)
		vis_contents -= hover_overlays_cache[overlay_icon][hovering]
		hovering = null

/atom/movable/screen/enhanced_sel/proc/set_selected_zone(choice, mob/user)
	if(user != hud?.mymob)
		return

	if(choice != hud.mymob.zone_selected)
		hud.mymob.zone_selected = choice
		hud.zone_select?.update_appearance()
		update_appearance()

	if(isliving(hud.mymob))
		var/mob/living/living_mob = hud.mymob
		//Update the hand shit
		living_mob.hand_index_to_zone[living_mob.active_hand_index] = living_mob.zone_selected

	return TRUE

/atom/movable/screen/enhanced_sel/proc/get_zone_at(icon_x, icon_y)
	if(icon_state == "[base_icon_state]_head")
		switch(icon_y)
			if(6) //Jaw
				switch(icon_x)
					if(13 to 19)
						return BODY_ZONE_PRECISE_MOUTH
			if(7) //Jaw
				switch(icon_x)
					if(12 to 20)
						return BODY_ZONE_PRECISE_MOUTH
			if(8, 9) //Jaw
				switch(icon_x)
					if(11 to 21)
						return BODY_ZONE_PRECISE_MOUTH
			if(10) //Jaw
				switch(icon_x)
					if(10 to 22)
						return BODY_ZONE_PRECISE_MOUTH
			if(11) //Jaw
				switch(icon_x)
					if(9 to 23)
						return BODY_ZONE_PRECISE_MOUTH
			if(12) //Jaw, face
				switch(icon_x)
					if(9, 10)
						return BODY_ZONE_PRECISE_MOUTH
					if(11 to 21)
						return BODY_ZONE_PRECISE_FACE
					if(22, 23)
						return BODY_ZONE_PRECISE_MOUTH
			if(13) //Face
				switch(icon_x)
					if(8 to 24)
						return BODY_ZONE_PRECISE_FACE
			if(14 to 16) //Face
				switch(icon_x)
					if(7 to 25)
						return BODY_ZONE_PRECISE_FACE
			if(17) //Face, eyes
				switch(icon_x)
					if(7 to 9)
						return BODY_ZONE_PRECISE_FACE
					if(10 to 13)
						return BODY_ZONE_PRECISE_R_EYE
					if(14 to 18)
						return BODY_ZONE_PRECISE_FACE
					if(19 to 22)
						return BODY_ZONE_PRECISE_L_EYE
					if(23 to 25)
						return BODY_ZONE_PRECISE_FACE
			if(18, 19) //Face, eyes
				switch(icon_x)
					if(7,8)
						return BODY_ZONE_PRECISE_FACE
					if(9 to 14)
						return BODY_ZONE_PRECISE_R_EYE
					if(15 to 17)
						return BODY_ZONE_PRECISE_FACE
					if(18 to 23)
						return BODY_ZONE_PRECISE_L_EYE
					if(24, 25)
						return BODY_ZONE_PRECISE_FACE
			if(20) //Face, eyes
				switch(icon_x)
					if(7 to 9)
						return BODY_ZONE_PRECISE_FACE
					if(10 to 13)
						return BODY_ZONE_PRECISE_R_EYE
					if(14 to 18)
						return BODY_ZONE_PRECISE_FACE
					if(19 to 22)
						return BODY_ZONE_PRECISE_L_EYE
					if(23 to 25)
						return BODY_ZONE_PRECISE_FACE
			if(21, 22) //Head, face
				switch(icon_x)
					if(7,8)
						return BODY_ZONE_HEAD
					if(9 to 23)
						return BODY_ZONE_PRECISE_FACE
					if(24,25)
						return BODY_ZONE_HEAD
			if(23) //Head, face
				switch(icon_x)
					if(7 to 9)
						return BODY_ZONE_HEAD
					if(10 to 13)
						return BODY_ZONE_PRECISE_FACE
					if(14 to 18)
						return BODY_ZONE_HEAD
					if(19 to 22)
						return BODY_ZONE_PRECISE_FACE
					if(23 to 25)
						return BODY_ZONE_HEAD
			if(24) //Head
				switch(icon_x)
					if(7 to 25)
						return BODY_ZONE_HEAD
			if(25) //Head
				switch(icon_x)
					if(8 to 24)
						return BODY_ZONE_HEAD
			if(26) //Head
				switch(icon_x)
					if(9 to 23)
						return BODY_ZONE_HEAD
			if(27) //Head
				switch(icon_x)
					if(10 to 22)
						return BODY_ZONE_HEAD
			if(28)
				switch(icon_x)
					if(12 to 20)
						return BODY_ZONE_HEAD
	else if(icon_state == "[base_icon_state]_hand_r")
		switch(icon_y)
			if(7) //Hand
				switch(icon_x)
					if(15 to 20)
						return BODY_ZONE_PRECISE_R_HAND
			if(8) //Hand
				switch(icon_x)
					if(14 to 21)
						return BODY_ZONE_PRECISE_R_HAND
			if(9) //Hand
				switch(icon_x)
					if(14 to 22)
						return BODY_ZONE_PRECISE_R_HAND
			if(10) //Hand, thumb
				switch(icon_x)
					if(13)
						return BODY_ZONE_PRECISE_R_FINGER_THUMB
					if(14 to 22)
						return BODY_ZONE_PRECISE_R_HAND
			if(11) //Hand, thumb
				switch(icon_x)
					if(12 to 14)
						return BODY_ZONE_PRECISE_R_FINGER_THUMB
					if(15 to 23)
						return BODY_ZONE_PRECISE_R_HAND
			if(12) //Hand, thumb
				switch(icon_x)
					if(11 to 14)
						return BODY_ZONE_PRECISE_R_FINGER_THUMB
					if(15 to 23)
						return BODY_ZONE_PRECISE_R_HAND
			if(13) //Hand, thumb
				switch(icon_x)
					if(10 to 13)
						return BODY_ZONE_PRECISE_R_FINGER_THUMB
					if(14 to 23)
						return BODY_ZONE_PRECISE_R_HAND
			if(14) //Hand, thumb
				switch(icon_x)
					if(9 to 12)
						return BODY_ZONE_PRECISE_R_FINGER_THUMB
					if(13 to 23)
						return BODY_ZONE_PRECISE_R_HAND
			if(15) //Hand, thumb
				switch(icon_x)
					if(8 to 11)
						return BODY_ZONE_PRECISE_R_FINGER_THUMB
					if(12 to 23)
						return BODY_ZONE_PRECISE_R_HAND
			if(16) //Hand, thumb
				switch(icon_x)
					if(8 to 10)
						return BODY_ZONE_PRECISE_R_FINGER_THUMB
					if(12 to 23)
						return BODY_ZONE_PRECISE_R_HAND
			if(17) //Hand, pinky
				switch(icon_x)
					if(12 to 21)
						return BODY_ZONE_PRECISE_R_HAND
					if(22, 23)
						return BODY_ZONE_PRECISE_R_FINGER_PINKY
			if(18) //Hand, ring, pinky
				switch(icon_x)
					if(12 to 20)
						return BODY_ZONE_PRECISE_R_HAND
					if(21)
						return BODY_ZONE_PRECISE_R_FINGER_RING
					if(22, 23)
						return BODY_ZONE_PRECISE_R_FINGER_PINKY
			if(19) //Index, hand, ring,  pinky
				switch(icon_x)
					if(12, 13)
						return BODY_ZONE_PRECISE_R_FINGER_INDEX
					if(14 to 19)
						return BODY_ZONE_PRECISE_R_HAND
					if(20, 21)
						return BODY_ZONE_PRECISE_R_FINGER_RING
					if(22, 23)
						return BODY_ZONE_PRECISE_R_FINGER_PINKY
			if(20 to 22) //Index, middle, ring, pinky
				switch(icon_x)
					if(12 to 14)
						return BODY_ZONE_PRECISE_R_FINGER_INDEX
					if(15 to 17)
						return BODY_ZONE_PRECISE_R_FINGER_MIDDLE
					if(18 to 21)
						return BODY_ZONE_PRECISE_R_FINGER_RING
					if(22, 23)
						return BODY_ZONE_PRECISE_R_FINGER_PINKY
			if(23) //Index, middle, ring, pinky
				switch(icon_x)
					if(12 to 14)
						return BODY_ZONE_PRECISE_R_FINGER_INDEX
					if(15 to 17)
						return BODY_ZONE_PRECISE_R_FINGER_MIDDLE
					if(18 to 21)
						return BODY_ZONE_PRECISE_R_FINGER_RING
					if(22)
						return BODY_ZONE_PRECISE_R_FINGER_PINKY
			if(24 to 26) //Index, middle, ring
				switch(icon_x)
					if(12 to 14)
						return BODY_ZONE_PRECISE_R_FINGER_INDEX
					if(15 to 17)
						return BODY_ZONE_PRECISE_R_FINGER_MIDDLE
					if(18 to 21)
						return BODY_ZONE_PRECISE_R_FINGER_RING
			if(27) //Index, middle, ring
				switch(icon_x)
					if(13, 14)
						return BODY_ZONE_PRECISE_R_FINGER_INDEX
					if(16, 17)
						return BODY_ZONE_PRECISE_R_FINGER_MIDDLE
					if(19 to 21)
						return BODY_ZONE_PRECISE_R_FINGER_RING
	else if(icon_state == "[base_icon_state]_hand_l")
		switch(icon_y)
			if(7) //Hand
				switch(abs(icon_x-33))
					if(15 to 20)
						return BODY_ZONE_PRECISE_L_HAND
			if(8) //Hand
				switch(abs(icon_x-33))
					if(14 to 21)
						return BODY_ZONE_PRECISE_L_HAND
			if(9) //Hand
				switch(abs(icon_x-33))
					if(14 to 22)
						return BODY_ZONE_PRECISE_L_HAND
			if(10) //Hand, thumb
				switch(abs(icon_x-33))
					if(13)
						return BODY_ZONE_PRECISE_L_FINGER_THUMB
					if(14 to 22)
						return BODY_ZONE_PRECISE_L_HAND
			if(11) //Hand, thumb
				switch(abs(icon_x-33))
					if(12 to 14)
						return BODY_ZONE_PRECISE_L_FINGER_THUMB
					if(15 to 23)
						return BODY_ZONE_PRECISE_L_HAND
			if(12) //Hand, thumb
				switch(abs(icon_x-33))
					if(11 to 14)
						return BODY_ZONE_PRECISE_L_FINGER_THUMB
					if(15 to 23)
						return BODY_ZONE_PRECISE_L_HAND
			if(13) //Hand, thumb
				switch(abs(icon_x-33))
					if(10 to 13)
						return BODY_ZONE_PRECISE_L_FINGER_THUMB
					if(14 to 23)
						return BODY_ZONE_PRECISE_L_HAND
			if(14) //Hand, thumb
				switch(abs(icon_x-33))
					if(9 to 12)
						return BODY_ZONE_PRECISE_L_FINGER_THUMB
					if(13 to 23)
						return BODY_ZONE_PRECISE_L_HAND
			if(15) //Hand, thumb
				switch(abs(icon_x-33))
					if(8 to 11)
						return BODY_ZONE_PRECISE_L_FINGER_THUMB
					if(12 to 23)
						return BODY_ZONE_PRECISE_L_HAND
			if(16) //Hand, thumb
				switch(abs(icon_x-33))
					if(8 to 10)
						return BODY_ZONE_PRECISE_L_FINGER_THUMB
					if(12 to 23)
						return BODY_ZONE_PRECISE_L_HAND
			if(17) //Hand, pinky
				switch(abs(icon_x-33))
					if(12 to 21)
						return BODY_ZONE_PRECISE_L_HAND
					if(22, 23)
						return BODY_ZONE_PRECISE_L_FINGER_PINKY
			if(18) //Hand, ring, pinky
				switch(abs(icon_x-33))
					if(12 to 20)
						return BODY_ZONE_PRECISE_L_HAND
					if(21)
						return BODY_ZONE_PRECISE_L_FINGER_RING
					if(22, 23)
						return BODY_ZONE_PRECISE_L_FINGER_PINKY
			if(19) //Index, hand, ring,  pinky
				switch(abs(icon_x-33))
					if(12, 13)
						return BODY_ZONE_PRECISE_L_FINGER_INDEX
					if(14 to 19)
						return BODY_ZONE_PRECISE_L_HAND
					if(20, 21)
						return BODY_ZONE_PRECISE_L_FINGER_RING
					if(22, 23)
						return BODY_ZONE_PRECISE_L_FINGER_PINKY
			if(20 to 22) //Index, middle, ring, pinky
				switch(abs(icon_x-33))
					if(12 to 14)
						return BODY_ZONE_PRECISE_L_FINGER_INDEX
					if(15 to 17)
						return BODY_ZONE_PRECISE_L_FINGER_MIDDLE
					if(18 to 21)
						return BODY_ZONE_PRECISE_L_FINGER_RING
					if(22, 23)
						return BODY_ZONE_PRECISE_L_FINGER_PINKY
			if(23) //Index, middle, ring, pinky
				switch(abs(icon_x-33))
					if(12 to 14)
						return BODY_ZONE_PRECISE_L_FINGER_INDEX
					if(15 to 17)
						return BODY_ZONE_PRECISE_L_FINGER_MIDDLE
					if(18 to 21)
						return BODY_ZONE_PRECISE_L_FINGER_RING
					if(22)
						return BODY_ZONE_PRECISE_L_FINGER_PINKY
			if(24 to 26) //Index, middle, ring
				switch(abs(icon_x-33))
					if(12 to 14)
						return BODY_ZONE_PRECISE_L_FINGER_INDEX
					if(15 to 17)
						return BODY_ZONE_PRECISE_L_FINGER_MIDDLE
					if(18 to 21)
						return BODY_ZONE_PRECISE_L_FINGER_RING
			if(27) //Index, middle, ring
				switch(abs(icon_x-33))
					if(13, 14)
						return BODY_ZONE_PRECISE_L_FINGER_INDEX
					if(16, 17)
						return BODY_ZONE_PRECISE_L_FINGER_MIDDLE
					if(19 to 21)
						return BODY_ZONE_PRECISE_L_FINGER_RING
	else if(icon_state == "[base_icon_state]_foot_r")
		switch(icon_y)
			if(5) //Big toe
				switch(icon_x)
					if(15 to 17)
						return BODY_ZONE_PRECISE_R_TOE_BIG
			if(6) //Big toe, long toe
				switch(icon_x)
					if(13, 14)
						return BODY_ZONE_PRECISE_R_TOE_LONG
					if(15 to 18)
						return BODY_ZONE_PRECISE_R_TOE_BIG
			if(7) //Big toe, long toe, middle toe
				switch(icon_x)
					if(11, 12)
						return BODY_ZONE_PRECISE_R_TOE_MIDDLE
					if(13, 14)
						return BODY_ZONE_PRECISE_R_TOE_LONG
					if(15 to 18)
						return BODY_ZONE_PRECISE_R_TOE_BIG
			if(8) //Big toe, long toe, middle toe, ring toe
				switch(icon_x)
					if(10)
						return BODY_ZONE_PRECISE_R_TOE_RING
					if(11, 12)
						return BODY_ZONE_PRECISE_R_TOE_MIDDLE
					if(13, 14)
						return BODY_ZONE_PRECISE_R_TOE_LONG
					if(15 to 18)
						return BODY_ZONE_PRECISE_R_TOE_BIG
			if(9) //Big toe, long toe, middle toe, ring toe
				switch(icon_x)
					if(9, 10)
						return BODY_ZONE_PRECISE_R_TOE_RING
					if(11, 12)
						return BODY_ZONE_PRECISE_R_TOE_MIDDLE
					if(13 to 15)
						return BODY_ZONE_PRECISE_R_TOE_LONG
					if(16 to 18)
						return BODY_ZONE_PRECISE_R_TOE_BIG
			if(10) //Big toe, long toe, middle toe, ring toe, pinky toe
				switch(icon_x)
					if(8)
						return BODY_ZONE_PRECISE_R_TOE_PINKY
					if(9, 10)
						return BODY_ZONE_PRECISE_R_TOE_RING
					if(11, 12)
						return BODY_ZONE_PRECISE_R_TOE_MIDDLE
					if(13 to 15)
						return BODY_ZONE_PRECISE_R_TOE_LONG
					if(16 to 18)
						return BODY_ZONE_PRECISE_R_TOE_BIG
			if(11) //Ring toe, pinky toe
				switch(icon_x)
					if(8)
						return BODY_ZONE_PRECISE_R_TOE_PINKY
					if(9, 10)
						return BODY_ZONE_PRECISE_R_TOE_RING
					if(11 to 18)
						return BODY_ZONE_PRECISE_R_FOOT
			if(12, 13) //Pinky toe, foot
				switch(icon_x)
					if(8, 9)
						return BODY_ZONE_PRECISE_R_TOE_PINKY
					if(10 to 19)
						return BODY_ZONE_PRECISE_R_FOOT
			if(14) //Pinky toe, foot
				switch(icon_x)
					if(9)
						return BODY_ZONE_PRECISE_R_TOE_PINKY
					if(10 to 19)
						return BODY_ZONE_PRECISE_R_FOOT
			if(15) //Foot
				switch(icon_x)
					if(10 to 19)
						return BODY_ZONE_PRECISE_R_FOOT
			if(16) //Foot
				switch(icon_x)
					if(11 to 19)
						return BODY_ZONE_PRECISE_R_FOOT
			if(17) //Foot
				switch(icon_x)
					if(12 to 19)
						return BODY_ZONE_PRECISE_R_FOOT
			if(18) //Foot
				switch(icon_x)
					if(13 to 22)
						return BODY_ZONE_PRECISE_R_FOOT
			if(19 to 21) //Foot
				switch(icon_x)
					if(13 to 23)
						return BODY_ZONE_PRECISE_R_FOOT
			if(22, 23)
				switch(icon_x)
					if(14 to 22)
						return BODY_ZONE_PRECISE_R_FOOT
			if(24)
				switch(icon_x)
					if(15 to 21)
						return BODY_ZONE_PRECISE_R_FOOT
			if(25 to 27)
				switch(icon_x)
					if(16 to 20)
						return BODY_ZONE_PRECISE_R_FOOT
			if(28)
				switch(icon_x)
					if(16 to 19)
						return BODY_ZONE_PRECISE_R_FOOT
			if(29)
				switch(icon_x)
					if(16 to 18)
						return BODY_ZONE_PRECISE_R_FOOT
	else if(icon_state == "[base_icon_state]_foot_l")
		switch(icon_y)
			if(5) //Big toe
				switch(abs(icon_x-33))
					if(15 to 17)
						return BODY_ZONE_PRECISE_L_TOE_BIG
			if(6) //Big toe, long toe
				switch(abs(icon_x-33))
					if(13, 14)
						return BODY_ZONE_PRECISE_L_TOE_LONG
					if(15 to 18)
						return BODY_ZONE_PRECISE_L_TOE_BIG
			if(7) //Big toe, long toe, middle toe
				switch(abs(icon_x-33))
					if(11, 12)
						return BODY_ZONE_PRECISE_L_TOE_MIDDLE
					if(13, 14)
						return BODY_ZONE_PRECISE_L_TOE_LONG
					if(15 to 18)
						return BODY_ZONE_PRECISE_L_TOE_BIG
			if(8) //Big toe, long toe, middle toe, ring toe
				switch(abs(icon_x-33))
					if(10)
						return BODY_ZONE_PRECISE_L_TOE_RING
					if(11, 12)
						return BODY_ZONE_PRECISE_L_TOE_MIDDLE
					if(13, 14)
						return BODY_ZONE_PRECISE_L_TOE_LONG
					if(15 to 18)
						return BODY_ZONE_PRECISE_L_TOE_BIG
			if(9) //Big toe, long toe, middle toe, ring toe
				switch(abs(icon_x-33))
					if(9, 10)
						return BODY_ZONE_PRECISE_L_TOE_RING
					if(11, 12)
						return BODY_ZONE_PRECISE_L_TOE_MIDDLE
					if(13 to 15)
						return BODY_ZONE_PRECISE_L_TOE_LONG
					if(16 to 18)
						return BODY_ZONE_PRECISE_L_TOE_BIG
			if(10) //Big toe, long toe, middle toe, ring toe, pinky toe
				switch(abs(icon_x-33))
					if(8)
						return BODY_ZONE_PRECISE_L_TOE_PINKY
					if(9, 10)
						return BODY_ZONE_PRECISE_L_TOE_RING
					if(11, 12)
						return BODY_ZONE_PRECISE_L_TOE_MIDDLE
					if(13 to 15)
						return BODY_ZONE_PRECISE_L_TOE_LONG
					if(16 to 18)
						return BODY_ZONE_PRECISE_L_TOE_BIG
			if(11) //Ring toe, pinky toe
				switch(abs(icon_x-33))
					if(8)
						return BODY_ZONE_PRECISE_L_TOE_PINKY
					if(9, 10)
						return BODY_ZONE_PRECISE_L_TOE_RING
					if(11 to 18)
						return BODY_ZONE_PRECISE_L_FOOT
			if(12, 13) //Pinky toe, foot
				switch(abs(icon_x-33))
					if(8, 9)
						return BODY_ZONE_PRECISE_L_TOE_PINKY
					if(10 to 19)
						return BODY_ZONE_PRECISE_L_FOOT
			if(14) //Pinky toe, foot
				switch(abs(icon_x-33))
					if(9)
						return BODY_ZONE_PRECISE_L_TOE_PINKY
					if(10 to 19)
						return BODY_ZONE_PRECISE_L_FOOT
			if(15) //Foot
				switch(abs(icon_x-33))
					if(10 to 19)
						return BODY_ZONE_PRECISE_R_FOOT
			if(16) //Foot
				switch(abs(icon_x-33))
					if(11 to 19)
						return BODY_ZONE_PRECISE_R_FOOT
			if(17) //Foot
				switch(abs(icon_x-33))
					if(12 to 19)
						return BODY_ZONE_PRECISE_R_FOOT
			if(18) //Foot
				switch(abs(icon_x-33))
					if(13 to 22)
						return BODY_ZONE_PRECISE_R_FOOT
			if(19 to 21) //Foot
				switch(abs(icon_x-33))
					if(13 to 23)
						return BODY_ZONE_PRECISE_R_FOOT
			if(22, 23)
				switch(abs(icon_x-33))
					if(14 to 22)
						return BODY_ZONE_PRECISE_R_FOOT
			if(24)
				switch(abs(icon_x-33))
					if(15 to 21)
						return BODY_ZONE_PRECISE_R_FOOT
			if(25 to 27)
				switch(abs(icon_x-33))
					if(16 to 20)
						return BODY_ZONE_PRECISE_R_FOOT
			if(28)
				switch(abs(icon_x-33))
					if(16 to 19)
						return BODY_ZONE_PRECISE_R_FOOT
			if(29)
				switch(abs(icon_x-33))
					if(16 to 18)
						return BODY_ZONE_PRECISE_R_FOOT
