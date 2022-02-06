/obj/item/clothing/under
	worn_icon_digi = 'modular_septic/icons/mob/clothing/under/uniform_digi.dmi'
	mutant_variants = NONE
	carry_weight = 0.5
	var/sleeve_wording = "sleeve"
	var/sleeve_rip_delay = 1 SECONDS
	var/sleeves = ARM_RIGHT|ARM_LEFT|LEG_RIGHT|LEG_LEFT

/obj/item/clothing/under/attack_hand_tertiary(mob/user, params)
	. = ..()
	var/mob/living/living_user = user
	if(!istype(living_user))
		return
	if(sleeves)
		var/disabled_bitflags = (initial(body_parts_covered) & ~(initial(body_parts_covered) & body_parts_covered))
		for(var/rippable_bitflag in list(ARM_RIGHT, ARM_LEFT, LEG_RIGHT, LEG_LEFT))
			if(!(sleeves & rippable_bitflag) || (disabled_bitflags & rippable_bitflag))
				continue
			var/rippable_zone = GLOB.bitflag_to_bodyzone["[rippable_bitflag]"]
			if(!rippable_zone)
				continue
			to_chat(user, span_warning("I start ripping off [prefix_a_or_an(sleeve_wording)] from [src]..."))
			if(!do_after(user, sleeve_rip_delay))
				to_chat(user, span_warning(fail_msg()))
				return
			to_chat(user, span_notice("I rip [prefix_a_or_an(sleeve_wording)] [sleeve_wording] from [src]."))
			disable_zone(rippable_zone, BRUTE)
			playsound(src, 'modular_septic/sound/effects/clothripping.ogg', 40, 0, -2)
			var/obj/item/repairable_by_result = new repairable_by(loc)
			if(istype(repairable_by_result, /obj/item/stack))
				var/obj/item/stack/stackable_result = repairable_by_result
				stackable_result.amount = 1
			user.put_in_hands(repairable_by_result)
			return
		to_chat(user, span_warning("[src] has no [sleeve_wording]."))
	else
		to_chat(user, span_warning("I can't rip any [sleeve_wording] from [src]."))
	return COMPONENT_TERTIARY_CANCEL_ATTACK_CHAIN
