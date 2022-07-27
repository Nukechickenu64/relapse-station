/mob/living/carbon/human/CanAllowThrough(atom/movable/mover, border_dir)
	. = ..()
	if(mover.throwing && isitem(mover) && ishuman(mover.throwing.thrower))
		var/mob/living/carbon/human/human_thrower = mover.throwing.thrower
		if(human_thrower.diceroll(GET_MOB_SKILL_VALUE(human_thrower, SKILL_THROWING), context = DICE_CONTEXT_PHYSICAL) <= DICE_FAILURE)
			return TRUE

/mob/living/carbon/human/Move(NewLoc, direct)
	. = ..()
	if(shoes || wear_suit && body_position == STANDING_UP && loc == NewLoc && has_gravity(loc))
		SEND_SIGNAL(shoes, COMSIG_SHOES_STEP_ACTION)
