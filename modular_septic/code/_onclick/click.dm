//This was modified a lot, enough for modularization to make sense
/mob/ClickOn( atom/A, params )
	if(world.time <= next_click)
		return
	next_click = world.time + 1

	if(check_click_intercept(params,A))
		return

	if(notransform)
		return

	if(SEND_SIGNAL(src, COMSIG_MOB_CLICKON, A, params) & COMSIG_MOB_CANCEL_CLICKON)
		return
	var/list/modifiers = params2list(params)
	if(LAZYACCESS(modifiers, SHIFT_CLICK))
		if(LAZYACCESS(modifiers, MIDDLE_CLICK))
			ShiftMiddleClickOn(A)
			return
		if(LAZYACCESS(modifiers, CTRL_CLICK))
			CtrlShiftClickOn(A)
			return
		ShiftClickOn(A)
		return
	if(LAZYACCESS(modifiers, MIDDLE_CLICK))
		if(LAZYACCESS(modifiers, ALT_CLICK))
			AltMiddleClickOn(A, params)
		else
			MiddleClickOn(A, params)
		return
	if(LAZYACCESS(modifiers, ALT_CLICK)) // alt and alt-gr (rightalt)
		if(LAZYACCESS(modifiers, RIGHT_CLICK))
			alt_click_on_secondary(A)
		else
			AltClickOn(A)
		return
	if(LAZYACCESS(modifiers, CTRL_CLICK))
		CtrlClickOn(A)
		return

	if(incapacitated(ignore_restraints = TRUE, ignore_stasis = TRUE))
		return

	face_atom(A)

	if(next_move > world.time) // in the year 2000...
		//spam prevention
		if(!(world.time % 3))
			to_chat(src, click_fail_msg())
		return

	if(!LAZYACCESS(modifiers, "catcher") && A.IsObscured())
		return

	if(HAS_TRAIT(src, TRAIT_HANDS_BLOCKED))
		changeNext_move(CLICK_CD_HANDCUFFED)   //Doing shit in cuffs shall be vey slow
		UnarmedAttack(A, FALSE, modifiers)
		return

	if(throw_mode)
		changeNext_move(CLICK_CD_THROW)
		throw_item(A)
		return

	var/obj/item/W = get_active_held_item()

	if(W == A)
		if(LAZYACCESS(modifiers, RIGHT_CLICK))
			W.attack_self_secondary(src, modifiers)
			update_inv_hands()
			return
		else
			W.attack_self(src, modifiers)
			update_inv_hands()
			return

	//These are always reachable.
	//User itself, current loc, and user inventory
	var/obj/item/atom_item
	if(isitem(A))
		atom_item = A
	if((A in DirectAccess()) || (atom_item?.stored_in && (atom_item.stored_in in DirectAccess()) ) )
		if(W)
			W.melee_attack_chain(src, A, params)
		else
			if(ismob(A))
				changeNext_move(CLICK_CD_MELEE)
			UnarmedAttack(A, FALSE, modifiers)
		return

	//Can't reach anything else in lockers or other weirdness
	if(!loc.AllowClick())
		return

	//Standard reach turf to turf or reaching inside storage
	if(CanReach(A,W) || (atom_item?.stored_in && CanReach(atom_item.stored_in, W)) )
		if(W)
			W.melee_attack_chain(src, A, params)
		else
			if(ismob(A))
				changeNext_move(CLICK_CD_MELEE)
			UnarmedAttack(A,1,modifiers)
	else
		if(W)
			if(LAZYACCESS(modifiers, RIGHT_CLICK))
				var/after_attack_secondary_result = W.afterattack_secondary(A, src, FALSE, params)

				if(after_attack_secondary_result == SECONDARY_ATTACK_CALL_NORMAL)
					W.afterattack(A, src, FALSE, params)
			else
				W.afterattack(A,src,0,params)
		else
			if(LAZYACCESS(modifiers, RIGHT_CLICK))
				ranged_secondary_attack(A, modifiers)
			else
				RangedAttack(A,modifiers)

/mob/proc/AltMiddleClickOn(atom/A, params)
	return look_into_distance(A, params)

/atom/proc/MiddleClick(mob/user, params)
	var/list/modifiers = params2list(params)
	if(SEND_SIGNAL(src, COMSIG_CLICK_MIDDLE, user) & COMPONENT_CANCEL_CLICK_MIDDLE)
		return TRUE
	if(user.incapacitated(ignore_restraints = TRUE, ignore_stasis = TRUE))
		return
	if(user.next_move > world.time)
		to_chat(src, click_fail_msg())
		return
	if(isliving(user))
		var/mob/living/living_user = user
		var/obj/item/atom_item
		if(isitem(src))
			atom_item = src
		var/canreach = FALSE
		if((src in living_user.DirectAccess()) || (atom_item?.stored_in && (atom_item.stored_in in living_user.DirectAccess()) ) )
			canreach = TRUE
		else if(living_user.CanReach(src) || (atom_item?.stored_in && living_user.CanReach(atom_item.stored_in)) )
			canreach = TRUE
		switch(living_user.special_attack)
			if(SPECIAL_ATK_BITE)
				if(canreach)
					if(ismob(src))
						user.changeNext_move(CLICK_CD_MELEE)
					return user.UnarmedJaw(src, canreach, modifiers)
			if(SPECIAL_ATK_KICK)
				if(canreach)
					if(ismob(src))
						user.changeNext_move(CLICK_CD_MELEE)
					return user.UnarmedFoot(src, canreach, modifiers)
			if(SPECIAL_ATK_JUMP)
				user.changeNext_move(CLICK_CD_JUMP)
				return user.MiddleClickJump(src, canreach, modifiers)
			else
				if(ismob(src))
					user.changeNext_move(CLICK_CD_MELEE)
				if(iscarbon(src))
					if(user.get_active_held_item())
						var/static/list/middleclick_steps = list(/datum/surgery_step/incise, /datum/surgery_step/mechanic_incise, /datum/surgery_step/dissect)
						for(var/datum/surgery_step/step as anything in GLOB.surgery_steps)
							if(!(step.type in middleclick_steps))
								continue
							if(step.try_op(user, src, user.zone_selected, user.get_active_held_item()))
								return TRUE
