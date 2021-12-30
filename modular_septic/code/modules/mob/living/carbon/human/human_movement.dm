/mob/living/carbon/human/CanAllowThrough(atom/movable/mover, border_dir)
	. = ..()
	if(mover.throwing && isitem(mover) && ishuman(mover.throwing.thrower))
		var/mob/living/carbon/human/human_thrower = mover.throwing.thrower
		if(human_thrower.diceroll(GET_MOB_SKILL_VALUE(human_thrower, SKILL_THROWING)) <= DICE_FAILURE)
			return TRUE
