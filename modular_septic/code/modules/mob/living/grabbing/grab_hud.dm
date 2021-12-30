/atom/movable/screen/grab
	name = "grab"
	icon = 'modular_septic/icons/hud/quake/grab.dmi'
	icon_state = "grab_wrench"
	base_icon_state = "grab"
	layer = MOB_LAYER
	plane = HUD_PLANE
	//Grab item we are allied to
	var/obj/item/grab/parent
	//Strangle active overlay
	var/static/strangle_active_image
	//Takedown active overlay
	var/static/takedown_active_image

/atom/movable/screen/grab/Click(location, control, params)
	if(parent)
		var/list/modifiers = params2list(params)
		var/icon_y = text2num(LAZYACCESS(modifiers, ICON_Y))
		switch(parent.grab_mode)
			if(GM_TEAROFF)
				if(usr.next_move <= world.time)
					if(icon_y <= 16)
						return parent.tear_off_limb()
					else
						return parent.wrench_limb()
			if(GM_EMBEDDED)
				if(usr.next_move <= world.time)
					if(icon_y <= 16)
						return parent.pull_embedded()
					else
						return parent.twist_embedded()
			else
				return usr.ClickOn(parent, params)
	else
		return ..()

/atom/movable/screen/grab/update_name(updates)
	. = ..()
	if(parent)
		name = "grabbing [parent.victim]"
	else
		name = "grab"

/atom/movable/screen/grab/examine(mob/user)
	if(parent)
		return parent.examine(user)
	else
		return ..()

/atom/movable/screen/grab/update_icon_state()
	. = ..()
	if(!parent?.grab_mode)
		icon_state = base_icon_state
	else
		icon_state = "[base_icon_state]_[parent.grab_mode]"

/atom/movable/screen/grab/update_overlays()
	. = ..()
	if(parent?.active)
		switch(parent.grab_mode)
			if(GM_STRANGLE)
				. += image(icon, src, "strangle_active")
			if(GM_TAKEDOWN)
				. += image(icon, src, "takedown_active")
