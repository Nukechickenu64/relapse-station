/client/MouseWheel(object, delta_x, delta_y, location, control, params)
	. = ..()
	if(delta_y && isliving(mob))
		var/mob/living/living_mob = mob
		if(delta_y > 0)
			switch(living_mob.m_intent)
				if(MOVE_INTENT_WALK)
					living_mob.toggle_move_intent(living_mob)
				if(MOVE_INTENT_RUN)
					if(living_mob.combat_flags & COMBAT_FLAG_SPRINT_ACTIVE)
						return
					living_mob.toggle_sprint()
		else
			switch(living_mob.m_intent)
				if(MOVE_INTENT_RUN)
					if(living_mob.combat_flags & COMBAT_FLAG_SPRINT_ACTIVE)
						living_mob.toggle_sprint()
						return
					living_mob.toggle_move_intent(living_mob)

/client/proc/do_fullscreen(activate = FALSE)
	if(activate)
		winset(src, "mainwindow", "is-maximized=true;can-resize=false;titlebar=false;statusbar=false;menu=false")
	else
		winset(src, "mainwindow", "is-maximized=false;can-resize=true;titlebar=true;statusbar=false;menu=menu")
	addtimer(CALLBACK(src, .verb/fit_viewport), 4 SECONDS)

/client/proc/do_winset(control_id, params)
	winset(src, control_id, params)
