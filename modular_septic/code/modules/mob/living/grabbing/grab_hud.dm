/atom/movable/screen/grab
	name = "grab"
	desc = "Holy shit you really shouldn't be reading this."
	icon = 'modular_septic/icons/hud/quake/grab.dmi'
	icon_state = "grab_wrench"
	base_icon_state = "grab"
	layer = MOB_LAYER
	plane = HUD_PLANE
	//Grab item we are allied to
	var/obj/item/grab/parent

/atom/movable/screen/grab/Click(location, control, params)
	if(parent)
		if(usr != parent.owner)
			return
		var/list/modifiers = params2list(params)
		var/icon_y = text2num(LAZYACCESS(modifiers, ICON_Y))
		switch(parent.grab_mode)
			if(GM_TEAROFF)
				if(COOLDOWN_FINISHED(usr, next_move))
					if(icon_y <= 16)
						return parent.tear_off_limb()
					else
						return parent.wrench_limb()
			if(GM_EMBEDDED)
				if(COOLDOWN_FINISHED(usr, next_move))
					if(icon_y <= 16)
						return parent.pull_embedded()
					else
						return parent.twist_embedded()
			if(GM_BITE)
				if(LAZYACCESS(modifiers, RIGHT_CLICK))
					parent.owner.dropItemToGround(parent)
					return
				else if(COOLDOWN_FINISHED(usr, next_move))
					return parent.bite_limb()
			else
				return usr.ClickOn(parent, params)
			return
	return ..()

/atom/movable/screen/grab/update_name(updates)
	. = ..()
	if(parent)
		if(parent.bite_grab)
			name = "biting [parent.victim]"
		else
			name = "grabbing [parent.victim]"
		parent.name = name
		return
	name = "grab"

/atom/movable/screen/grab/examine(mob/user)
	if(parent)
		return parent.examine(user)
	return ..()

/atom/movable/screen/grab/update_icon_state()
	. = ..()
	if(parent?.grab_mode)
		icon_state = "[base_icon_state]_[parent.grab_mode]"
		icon_state = base_icon_state
	else
		icon_state = base_icon_state

/atom/movable/screen/grab/update_overlays()
	. = ..()
	if(!parent?.active)
		return
	switch(parent.grab_mode)
		if(GM_STRANGLE)
			. += image(icon, src, "strangle_active")
		if(GM_TAKEDOWN)
			. += image(icon, src, "takedown_active")
